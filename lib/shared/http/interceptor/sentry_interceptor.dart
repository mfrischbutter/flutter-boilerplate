import 'package:dio/dio.dart';
import 'package:sentry/sentry.dart';

class SentryInterceptor extends InterceptorsWrapper {
  @override
  Future onResponse(Response response, handler) async {
    Sentry.addBreadcrumb(
      Breadcrumb(
        type: 'http',
        category: 'http',
        data: {
          'url': response.requestOptions.uri,
          'method': response.requestOptions.method,
          'status_code': response.statusCode,
        },
      ),
    );
    if (response.statusCode! >= 500) {
      Sentry.captureException(
        response,
        stackTrace: StackTrace.current,
        hint: 'Server Error, captured by DioInterceptor, onResponse',
      );
    }
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, handler) async {
    Sentry.addBreadcrumb(
      Breadcrumb(
        type: 'http',
        category: 'http',
        data: {
          'url': err.requestOptions.uri,
          'method': err.requestOptions.method,
          'status_code': err.response!.statusCode,
        },
      ),
    );
    Sentry.captureException(
      err,
      stackTrace: StackTrace.current,
      hint: 'Server Error, captured by DioInterceptor, onError',
    );
    return super.onError(err, handler);
  }
}
