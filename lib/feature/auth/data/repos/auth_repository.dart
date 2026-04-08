import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bookia/feature/auth/domain/entities/auth_entity.dart';
import 'package:bookia/feature/auth/domain/repos/base_auth_repo.dart';

class AuthRepository implements BaseAuthRepo {
  final BaseAuthRemoteDataSource remoteDataSource;

  const AuthRepository(this.remoteDataSource);

  @override
  Future<AuthEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final model = await remoteDataSource.login(email: email, password: password);
      return AuthEntity(
        token: model.data?.token,
        message: model.message,
        status: model.status,
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<AuthEntity> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final model = await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return AuthEntity(
        token: model.data?.token,
        message: model.message,
        status: model.status,
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<bool> forgetPassword({required String email}) async {
    try {
      return await remoteDataSource.forgetPassword(email: email);
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<bool> checkForgetPasswordCode({
    required String email,
    required String verifyCode,
  }) async {
    try {
      return await remoteDataSource.checkForgetPasswordCode(
        email: email,
        verifyCode: verifyCode,
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<bool> resetPassword({
    required String verifyCode,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      return await remoteDataSource.resetPassword(
        verifyCode: verifyCode,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<bool> logout() async {
    try {
      return await remoteDataSource.logout();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }
}
