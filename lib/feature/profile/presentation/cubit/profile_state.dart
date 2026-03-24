import 'package:bookia/feature/profile/data/models/order_history_response_model.dart';
import 'package:bookia/feature/profile/data/models/profile_response_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

// Get Profile States
class GetProfileLoading extends ProfileState {}
class GetProfileSuccess extends ProfileState {
  final User user;
  GetProfileSuccess(this.user);
}
class GetProfileError extends ProfileState {}

// Update Profile States
class UpdateProfileLoading extends ProfileState {}
class UpdateProfileSuccess extends ProfileState {}
class UpdateProfileError extends ProfileState {
  final String message;
  UpdateProfileError(this.message);
}

// Order History States
class GetOrderHistoryLoading extends ProfileState {}
class GetOrderHistorySuccess extends ProfileState {
  final List<OrderItem> orders;
  GetOrderHistorySuccess(this.orders);
}
class GetOrderHistoryError extends ProfileState {}

// Reset Password States
class ResetPasswordLoading extends ProfileState {}
class ResetPasswordSuccess extends ProfileState {}
class ResetPasswordError extends ProfileState {
  final String message;
  ResetPasswordError(this.message);
}
