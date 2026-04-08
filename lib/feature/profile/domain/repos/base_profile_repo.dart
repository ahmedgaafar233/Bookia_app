import 'package:bookia/feature/profile/data/models/order_history_response_model.dart';
import 'package:bookia/feature/profile/data/models/profile_response_model.dart';

abstract class BaseProfileRepo {
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
