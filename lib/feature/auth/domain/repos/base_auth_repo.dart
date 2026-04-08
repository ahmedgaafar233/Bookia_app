import 'package:bookia/feature/auth/domain/entities/auth_entity.dart';

abstract class BaseAuthRepo {
  Future<AuthEntity> login({
    required String email,
    required String password,
  });

  Future<AuthEntity> register({
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
