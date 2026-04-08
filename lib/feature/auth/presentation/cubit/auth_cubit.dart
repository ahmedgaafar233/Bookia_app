import 'package:bookia/feature/auth/domain/entities/auth_entity.dart';
import 'package:bookia/feature/auth/domain/repos/base_auth_repo.dart';
import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final BaseAuthRepo authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final entity = await authRepository.login(email: email, password: password);
      if (entity.status != null &&
          entity.status! >= 200 &&
          entity.status! < 300) {
        if (entity.token != null) {
          await SharedPrefs.cacheData(SharedPrefs.kToken, entity.token);
        }
        emit(AuthSuccess(entity));
      } else {
        emit(AuthError(entity.message ?? 'Login Failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(AuthLoading());
    try {
      final entity = await authRepository.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      if (entity.status != null &&
          entity.status! >= 200 &&
          entity.status! < 300) {
        emit(AuthSuccess(entity));
      } else {
        emit(AuthError(entity.message ?? 'Registration Failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> forgetPassword(String email) async {
    emit(AuthLoading());
    try {
      final success = await authRepository.forgetPassword(email: email);
      if (success) {
        emit(AuthSuccess(const AuthEntity(message: 'Code sent', status: 200)));
      } else {
        emit(AuthError('Failed to send code'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> checkCode(String email, String code) async {
    emit(AuthLoading());
    try {
      final success = await authRepository.checkForgetPasswordCode(
        email: email,
        verifyCode: code,
      );
      if (success) {
        emit(AuthSuccess(const AuthEntity(message: 'Code valid', status: 200)));
      } else {
        emit(AuthError('Invalid code'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword({
    required String code,
    required String password,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());
    try {
      final success = await authRepository.resetPassword(
        verifyCode: code,
        newPassword: password,
        newPasswordConfirmation: confirmPassword,
      );
      if (success) {
        emit(AuthSuccess(const AuthEntity(message: 'Password reset', status: 200)));
      } else {
        emit(AuthError('Reset failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      final success = await authRepository.logout();
      if (success) {
        await SharedPrefs.removeData(SharedPrefs.kToken);
        emit(AuthSuccess(const AuthEntity(message: 'Logout successful', status: 200)));
      } else {
        emit(AuthError('Logout failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
