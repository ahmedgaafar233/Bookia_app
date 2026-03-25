import 'package:dio/dio.dart';
import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConsumer {
  static final Dio _dio = Dio();
  static bool _initialized = false;

  DioConsumer() {
    if (!_initialized) {
      _dio.options.baseUrl = ApiConstants.baseUrl;
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
          final token = SharedPrefs.getData(SharedPrefs.kToken);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['Accept'] = 'application/json';
          return handler.next(options);
        },
      ),
    );
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
    ));
    _initialized = true;
    }
  }

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
