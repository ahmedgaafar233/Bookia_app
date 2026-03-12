part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final LoginResponseModel loginResponseModel;
  AuthSuccess(this.loginResponseModel);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
