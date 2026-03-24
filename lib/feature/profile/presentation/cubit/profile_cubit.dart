import 'package:bookia/feature/profile/data/repos/profile_repo.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(GetProfileLoading());
    try {
      final response = await _profileRepository.getProfile();
      if (response.status == 200 && response.data?.user != null) {
        emit(GetProfileSuccess(response.data!.user!));
      } else {
        emit(GetProfileError());
      }
    } catch (e) {
      emit(GetProfileError());
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String address,
  }) async {
    emit(UpdateProfileLoading());
    try {
      final response = await _profileRepository.updateProfile(
        name: name,
        phone: phone,
        address: address,
      );
      if (response.status == 200) {
        emit(UpdateProfileSuccess());
        getProfile(); // Refresh profile after update
      } else {
        emit(UpdateProfileError(response.message ?? 'Update failed'));
      }
    } catch (e) {
      emit(UpdateProfileError('An error occurred during update'));
    }
  }

  Future<void> getOrderHistory() async {
    emit(GetOrderHistoryLoading());
    try {
      final response = await _profileRepository.getOrderHistory();
      if (response.status == 200 && response.data?.orders != null) {
        emit(GetOrderHistorySuccess(response.data!.orders!));
      } else {
        emit(GetOrderHistoryError());
      }
    } catch (e) {
      emit(GetOrderHistoryError());
    }
  }

  Future<void> resetPassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    emit(ResetPasswordLoading());
    try {
      final success = await _profileRepository.resetPassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
      if (success) {
        emit(ResetPasswordSuccess());
      } else {
        emit(ResetPasswordError('Reset password failed'));
      }
    } catch (e) {
      emit(ResetPasswordError('An error occurred'));
    }
  }
}
