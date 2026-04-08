import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/feature/profile/data/datasources/profile_remote_data_source.dart';
import 'package:bookia/feature/profile/data/models/order_history_response_model.dart';
import 'package:bookia/feature/profile/data/models/profile_response_model.dart';
import 'package:bookia/feature/profile/domain/repos/base_profile_repo.dart';

class ProfileRepository implements BaseProfileRepo {
  final BaseProfileRemoteDataSource remoteDataSource;

  const ProfileRepository(this.remoteDataSource);

  @override
  Future<ProfileResponseModel> getProfile() async {
    try {
      return await remoteDataSource.getProfile();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<ProfileResponseModel> updateProfile({
    required String name,
    required String phone,
    required String address,
  }) async {
    try {
      return await remoteDataSource.updateProfile(
        name: name,
        phone: phone,
        address: address,
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<OrderHistoryResponseModel> getOrderHistory() async {
    try {
      return await remoteDataSource.getOrderHistory();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<bool> resetPassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      return await remoteDataSource.resetPassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }
}
