import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/shared/http/interceptor/dio_connectivity_request_retrier.dart';
import 'package:sentry/sentry.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (_shouldRetry(err)) {
      try {
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        Sentry.captureException(
          e,
          stackTrace: StackTrace.current,
          hint: 'Unable to schedule request retry',
        );
      }
    }
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.connectTimeout &&
        err.error != null &&
        err.error is SocketException;
  }
}
