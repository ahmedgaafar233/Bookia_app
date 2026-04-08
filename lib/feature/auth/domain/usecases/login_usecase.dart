import 'package:bookia/feature/auth/domain/entities/auth_entity.dart';
import 'package:bookia/feature/auth/domain/repos/base_auth_repo.dart';

class LoginUseCase {
  final BaseAuthRepo repo;
  const LoginUseCase(this.repo);

  Future<AuthEntity> call({
    required String email,
    required String password,
  }) {
    return repo.login(email: email, password: password);
  }
}
