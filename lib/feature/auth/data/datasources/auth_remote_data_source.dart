import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/auth/data/models/login_response_model.dart';
import 'package:dio/dio.dart';

abstract class BaseAuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });

  Future<LoginResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<bool> forgetPassword({required String email});

  Future<bool> checkForgetPasswordCode({
    required String email,
    required String verifyCode,
  });

  Future<bool> resetPassword({
    required String verifyCode,
    required String newPassword,
    required String newPasswordConfirmation,
  });

  Future<bool> logout();
}

class AuthRemoteDataSource implements BaseAuthRemoteDataSource {
  final DioConsumer dioConsumer;

  const AuthRemoteDataSource(this.dioConsumer);

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );
      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Login failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<LoginResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Registration failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<bool> forgetPassword({required String email}) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.forgetPassword,
        data: {'email': email},
      );
      return response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Request failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<bool> checkForgetPasswordCode({
    required String email,
    required String verifyCode,
  }) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.checkForgetPasswordCode,
        data: {'email': email, 'verify_code': verifyCode},
      );
      return response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Invalid code',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<bool> resetPassword({
    required String verifyCode,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.resetPassword,
        data: {
          'verify_code': verifyCode,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
      );
      return response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Reset failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final response = await dioConsumer.post(ApiConstants.logout);
      return response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Logout failed',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
