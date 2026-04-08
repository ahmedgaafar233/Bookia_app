import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/profile/data/models/order_history_response_model.dart';
import 'package:bookia/feature/profile/data/models/profile_response_model.dart';
import 'package:dio/dio.dart';

abstract class BaseProfileRemoteDataSource {
  Future<ProfileResponseModel> getProfile();
  Future<ProfileResponseModel> updateProfile({
    required String name,
    required String phone,
    required String address,
  });
  Future<OrderHistoryResponseModel> getOrderHistory();
  Future<bool> resetPassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  });
}

class ProfileRemoteDataSource implements BaseProfileRemoteDataSource {
  final DioConsumer dioConsumer;
  const ProfileRemoteDataSource(this.dioConsumer);

  @override
  Future<ProfileResponseModel> getProfile() async {
    try {
      final response = await dioConsumer.get(ApiConstants.showProfile);
      return ProfileResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch profile',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ProfileResponseModel> updateProfile({
    required String name,
    required String phone,
    required String address,
  }) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.updateProfile,
        data: {'name': name, 'phone': phone, 'address': address},
      );
      return ProfileResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to update profile',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<OrderHistoryResponseModel> getOrderHistory() async {
    try {
      final response = await dioConsumer.get(ApiConstants.orderHistory);
      return OrderHistoryResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to fetch orders',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<bool> resetPassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.editPassword,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Failed to reset password',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
