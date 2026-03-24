import 'package:bookia/core/network/api_constants.dart';
import 'package:bookia/core/network/dio_consumer.dart';

class SettingsRepository {
  final DioConsumer dioConsumer;

  SettingsRepository(this.dioConsumer);

  Future<dynamic> getFaqs() async {
    final response = await dioConsumer.get(ApiConstants.faqs);
    return response.data;
  }

  Future<dynamic> getSettings() async {
    final response = await dioConsumer.get(ApiConstants.settings);
    return response.data;
  }

  Future<dynamic> contactUs({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }) async {
    final response = await dioConsumer.post(
      ApiConstants.contactUs,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'subject': subject,
        'message': message,
      },
    );
    return response.data;
  }
}
