import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:dio/dio.dart';

abstract class BaseSettingsRemoteDataSource {
  Future<dynamic> getFaqs();
  Future<dynamic> getSettings();
  Future<dynamic> contactUs({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  });
}

class SettingsRemoteDataSource implements BaseSettingsRemoteDataSource {
  final DioConsumer dioConsumer;
  const SettingsRemoteDataSource(this.dioConsumer);

  @override
  Future<dynamic> getFaqs() async {
    try {
      final response = await dioConsumer.get(ApiConstants.faqs);
      return response.data;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch FAQs',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<dynamic> getSettings() async {
    try {
      final response = await dioConsumer.get(ApiConstants.settings);
      return response.data;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch settings',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<dynamic> contactUs({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.contactUs,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'subject': subject,
          'message': message,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to send message',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
