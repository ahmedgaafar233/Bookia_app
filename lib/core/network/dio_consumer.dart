import 'package:dio/dio.dart';
import 'package:bookia/core/network/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConsumer {
  static final Dio _dio = Dio();

  DioConsumer() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
    ));
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
