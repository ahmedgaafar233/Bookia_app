import 'package:bookia/core/errors/exceptions.dart';
import 'package:bookia/feature/settings/data/datasources/settings_remote_data_source.dart';
import 'package:bookia/feature/settings/domain/repos/base_settings_repo.dart';

class SettingsRepository implements BaseSettingsRepo {
  final BaseSettingsRemoteDataSource remoteDataSource;

  const SettingsRepository(this.remoteDataSource);

  @override
  Future<dynamic> getFaqs() async {
    try {
      return await remoteDataSource.getFaqs();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<dynamic> getSettings() async {
    try {
      return await remoteDataSource.getSettings();
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<dynamic> contactUs({
    required String name,
    required String email,
    required String phone,
    required String subject,
    required String message,
  }) async {
    try {
      return await remoteDataSource.contactUs(
        name: name,
        email: email,
        phone: phone,
        subject: subject,
        message: message,
      );
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }
}
