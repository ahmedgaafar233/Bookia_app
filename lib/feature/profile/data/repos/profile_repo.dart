import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/profile/data/models/order_history_response_model.dart';
import 'package:bookia/feature/profile/data/models/profile_response_model.dart';

class ProfileRepository {
  final DioConsumer dioConsumer;

  ProfileRepository(this.dioConsumer);

  Future<ProfileResponseModel> getProfile() async {
    final response = await dioConsumer.get(ApiConstants.showProfile);
    return ProfileResponseModel.fromJson(response.data);
  }

  Future<ProfileResponseModel> updateProfile({
    required String name,
    required String phone,
    required String address,
  }) async {
    final response = await dioConsumer.post(
      ApiConstants.updateProfile,
      data: {
        'name': name,
        'phone': phone,
        'address': address,
      },
    );
    return ProfileResponseModel.fromJson(response.data);
  }

  Future<OrderHistoryResponseModel> getOrderHistory() async {
    final response = await dioConsumer.get(ApiConstants.orderHistory);
    return OrderHistoryResponseModel.fromJson(response.data);
  }

  Future<bool> resetPassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final response = await dioConsumer.post(
      ApiConstants.editPassword,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      },
    );
    return response.statusCode == 200;
  }
}
