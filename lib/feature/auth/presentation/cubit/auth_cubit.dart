import 'package:bookia/feature/auth/data/models/login_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/feature/auth/data/repos/auth_repository.dart';

import 'package:bookia/core/services/local/shared_prefs.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final response = await authRepository.login(email: email, password: password);
      if (response.status != null && response.status! >= 200 && response.status! < 300) {
        if (response.data?.token != null) {
          await SharedPrefs.cacheData(SharedPrefs.kToken, response.data!.token);
        }
        emit(AuthSuccess(response));
      } else {
        emit(AuthError(response.message ?? 'Login Failed'));
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Login Failed';
      if (e.response?.data['errors'] != null) {
        final errors = e.response?.data['errors'] as Map<String, dynamic>;
        message = errors.values.map((v) {
          if (v is List) return v.join('\n');
          return v.toString();
        }).join('\n');
      }
      emit(AuthError(message));
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
      final response = await authRepository.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      if (response.status != null && response.status! >= 200 && response.status! < 300) {
        emit(AuthSuccess(response));
      } else {
        emit(AuthError(response.message ?? 'Registration Failed'));
      }
    } on DioException catch (e) {
      String message = e.response?.data['message'] ?? 'Registration Failed';
      if (e.response?.data['errors'] != null) {
        final errors = e.response?.data['errors'] as Map<String, dynamic>;
        message = errors.values.map((v) {
          if (v is List) return v.join('\n');
          return v.toString();
        }).join('\n');
      }
      emit(AuthError(message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> forgetPassword(String email) async {
    emit(AuthLoading());
    try {
      final success = await authRepository.forgetPassword(email: email);
      if (success) {
        emit(AuthSuccess(LoginResponseModel(message: 'Code sent', status: 200)));
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
      final success = await authRepository.checkForgetPasswordCode(email: email, verifyCode: code);
      if (success) {
        emit(AuthSuccess(LoginResponseModel(message: 'Code valid', status: 200)));
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
        emit(AuthSuccess(LoginResponseModel(message: 'Password reset', status: 200)));
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
        emit(AuthSuccess(LoginResponseModel(message: 'Logout successful', status: 200)));
      } else {
        emit(AuthError('Logout failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
