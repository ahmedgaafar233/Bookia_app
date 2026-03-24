abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsFaqsLoaded extends SettingsState {
  final dynamic faqs;
  SettingsFaqsLoaded(this.faqs);
}

class SettingsSettingsLoaded extends SettingsState {
  final dynamic settings;
  SettingsSettingsLoaded(this.settings);
}

class SettingsContactUsSuccess extends SettingsState {
  final String message;
  SettingsContactUsSuccess(this.message);
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}
