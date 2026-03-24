import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/auth/data/models/login_response_model.dart';

class AuthRepository {
  final DioConsumer dioConsumer;

  AuthRepository(this.dioConsumer);

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dioConsumer.post(
      ApiConstants.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    return LoginResponseModel.fromJson(response.data);
  }

  Future<LoginResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
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
  }

  Future<bool> forgetPassword({required String email}) async {
    final response = await dioConsumer.post(
      ApiConstants.forgetPassword,
      data: {'email': email},
    );
    return response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }

  Future<bool> checkForgetPasswordCode({
    required String email,
    required String verifyCode,
  }) async {
    final response = await dioConsumer.post(
      ApiConstants.checkForgetPasswordCode,
      data: {
        'email': email,
        'verify_code': verifyCode,
      },
    );
    return response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }

  Future<bool> resetPassword({
    required String verifyCode,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
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
  }

  Future<bool> logout() async {
    final response = await dioConsumer.post(ApiConstants.logout);
    return response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300;
  }
}
