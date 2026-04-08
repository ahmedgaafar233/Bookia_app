abstract class BaseSettingsRepo {
  Future<dynamic> getFaqs();
  Future<dynamic> getSettings();
  Future<dynamic> contactUs({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  });
}
