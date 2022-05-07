import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/shared/http/api_response.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/http/interceptor/dio_connectivity_request_retrier.dart';
import 'package:flutter_boilerplate/shared/http/interceptor/retry_interceptor.dart';
import 'package:flutter_boilerplate/shared/http/interceptor/sentry_interceptor.dart';
import 'package:flutter_boilerplate/shared/repository/token_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum ContentType { urlEncoded, json, multipart, image }

final apiProvider = Provider<ApiProvider>(
  (ref) => ApiProvider(ref.read),
);

class ApiProvider {
  ApiProvider(this._reader) {
    _dio = Dio();
    _dio.options.sendTimeout = 10000;
    _dio.options.connectTimeout = 10000;
    _dio.options.receiveTimeout = 10000;

    _dio.interceptors.add(
      SentryInterceptor(),
    );

    // _dio.interceptors.add(
    //   RetryInterceptor(
    //     dio: _dio,
    //     logPrint: print,
    //     retries: 3,
    //     retryDelays: const [
    //       Duration(seconds: 1),
    //       Duration(seconds: 2),
    //       Duration(seconds: 5),
    //     ],
    //   ),
    // );

    _dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    );

    // _dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onError: (error, handler) async {
    //       if (error.response != null) {
    //         if (error.response!.statusCode == 401) {
    //           await refreshToken();
    //           handler.resolve(await _retry(error.requestOptions));
    //         }
    //       }
    //       handler.reject(error);
    //     },
    //   ),
    // );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          error: true,
          requestHeader: true,
          compact: true,
        ),
      );
    }
  }

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   final options = new Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   return _dio.request<dynamic>(
  //     requestOptions.path,
  //     data: requestOptions.data,
  //     queryParameters: requestOptions.queryParameters,
  //     options: options,
  //   );
  // }

  // Future<void> refreshToken() async {
  //   final token = await _reader(tokenRepositoryProvider).fetchToken();
  //   final response = await this._dio.post(
  //     '/app:token/refresh/',
  //     data: {'token': token},
  //   );

  //   if (response.statusCode == 200) {
  //     _reader(tokenRepositoryProvider).saveToken(response.data['accessToken']);
  //   }
  // }

  final Reader _reader;

  late Dio _dio;

  late final TokenRepository _tokenRepository =
      _reader(tokenRepositoryProvider);

  get baseUrl async {
    dotenv.env['API'];
  }

  Future<APIResponse> post(
    String path,
    dynamic body, {
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return const APIResponse.error(AppException.connectivity());
    }

    try {
      final response = await _dio.post(
        baseUrl + path,
        data: body,
        queryParameters: query,
        options: Options(
          validateStatus: (status) => true,
          headers: await _generateHeaders(contentType),
        ),
      );

      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleDioError(e);
    } on Error catch (e) {
      return _handleError(e);
    }
  }

  Future<APIResponse> delete(
    String path,
    dynamic body, {
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return const APIResponse.error(AppException.connectivity());
    }

    try {
      final response = await _dio.delete(
        baseUrl + path,
        data: body,
        queryParameters: query,
        options: Options(
          validateStatus: (status) => true,
          headers: await _generateHeaders(contentType),
        ),
      );

      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleDioError(e);
    } on Error catch (e) {
      return _handleError(e);
    }
  }

  Future<APIResponse> patch(
    String path,
    dynamic body, {
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return const APIResponse.error(AppException.connectivity());
    }

    try {
      final response = await _dio.patch(
        baseUrl + path,
        data: body,
        queryParameters: query,
        options: Options(
          validateStatus: (status) => true,
          headers: await _generateHeaders(contentType),
        ),
      );

      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleDioError(e);
    } on Error catch (e) {
      return _handleError(e);
    }
  }

  Future<APIResponse> put(
    String path,
    dynamic body, {
    String? token,
    Map<String, String?>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return const APIResponse.error(AppException.connectivity());
    }

    try {
      final response = await _dio.put(
        baseUrl + path,
        data: body,
        queryParameters: query,
        options: Options(
          validateStatus: (status) => true,
          headers: await _generateHeaders(contentType),
        ),
      );

      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleDioError(e);
    } on Error catch (e) {
      return _handleError(e);
    }
  }

  Future<APIResponse> get(
    String path, {
    String? token,
    Map<String, dynamic>? query,
    ContentType contentType = ContentType.json,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return const APIResponse.error(AppException.connectivity());
    }

    try {
      final response = await _dio.get(
        baseUrl + path,
        queryParameters: query,
        options: Options(
          validateStatus: (status) => true,
          headers: await _generateHeaders(contentType),
        ),
      );
      return _handleResponse(response);
    } on DioError catch (e) {
      return _handleDioError(e);
    } on Error catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> _generateHeaders(
      [ContentType contentType = ContentType.json]) async {
    String content = '';
    switch (contentType) {
      case ContentType.json:
        content = 'application/json';
        break;
      case ContentType.multipart:
        content = 'multipart/form-data';
        break;
      case ContentType.urlEncoded:
        content = 'application/x-www-form-urlencoded';
        break;
      case ContentType.image:
        content = 'image/jpeg';
        break;
    }

    final headers = {
      'accept': '*/*',
      'Content-Type': content,
    };
    final _appToken = await _tokenRepository.fetchToken();
    if (_appToken != null) {
      headers['Authorization'] = 'Bearer ${_appToken.token}';
    }
    return headers;
  }

  APIResponse _handleResponse(Response response) {
    if (response.statusCode == null) {
      return const APIResponse.error(AppException.connectivity());
    }

    if (response.statusCode! < 300) {
      return APIResponse.success(response.data);
    } else {
      if (response.statusCode! == 404) {
        return const APIResponse.error(AppException.notFound());
      } else if (response.statusCode! == 401) {
        return const APIResponse.error(AppException.unauthorized());
      } else if (response.statusCode! == 403) {
        return const APIResponse.error(AppException.forbidden());
      } else if (response.statusCode! >= 500) {
        if (response.data['message'] != null) {
          return APIResponse.error(
            AppException.errorWithMessage(response.data['message'] ?? ''),
          );
        }
        return APIResponse.error(
            AppException.errorWithMessage(response.data.toString()));
      }
      return const APIResponse.error(AppException.error());
    }
  }

  APIResponse _handleDioError(DioError e) {
    if (e.error is SocketException) {
      return const APIResponse.error(AppException.connectivity());
    }
    if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout) {
      return const APIResponse.error(AppException.connectivity());
    }

    if (e.response != null) {
      if (e.response!.data['message'] != null) {
        return APIResponse.error(
          AppException.errorWithMessage(
            e.response!.data['message'],
          ),
        );
      }
    }
    return APIResponse.error(
      AppException.errorWithMessage(e.message),
    );
  }

  APIResponse _handleError(Error e) {
    return APIResponse.error(
      AppException.errorWithMessage(
        e.stackTrace.toString(),
      ),
    );
  }
}
