import 'package:bookia/feature/settings/domain/repos/base_settings_repo.dart';
import 'package:bookia/feature/settings/presentation/cubit/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final BaseSettingsRepo settingsRepository;

  SettingsCubit(this.settingsRepository) : super(SettingsInitial());

  Future<void> getFaqs() async {
    emit(SettingsLoading());
    try {
      final faqs = await settingsRepository.getFaqs();
      emit(SettingsFaqsLoaded(faqs));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> getSettings() async {
    emit(SettingsLoading());
    try {
      final settings = await settingsRepository.getSettings();
      emit(SettingsSettingsLoaded(settings));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> contactUs({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }) async {
    emit(SettingsLoading());
    try {
      await settingsRepository.contactUs(
        name: name,
        email: email,
        phone: phone,
        subject: subject,
        message: message,
      );
      emit(SettingsContactUsSuccess('Message sent successfully!'));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
