import 'package:bookia/feature/auth/domain/entities/auth_entity.dart';
import 'package:bookia/feature/auth/domain/repos/base_auth_repo.dart';

class RegisterUseCase {
  final BaseAuthRepo repo;
  const RegisterUseCase(this.repo);

  Future<AuthEntity> call({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {
    return repo.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
