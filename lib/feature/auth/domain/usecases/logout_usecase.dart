import 'package:bookia/feature/auth/domain/repos/base_auth_repo.dart';

class LogoutUseCase {
  final BaseAuthRepo repo;
  const LogoutUseCase(this.repo);

  Future<bool> call() => repo.logout();
}
