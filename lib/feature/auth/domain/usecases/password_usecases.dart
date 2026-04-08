import 'package:bookia/feature/auth/domain/repos/base_auth_repo.dart';

class ForgetPasswordUseCase {
  final BaseAuthRepo repo;
  const ForgetPasswordUseCase(this.repo);

  Future<bool> call({required String email}) =>
      repo.forgetPassword(email: email);
}

class CheckForgetPasswordCodeUseCase {
  final BaseAuthRepo repo;
  const CheckForgetPasswordCodeUseCase(this.repo);

  Future<bool> call({required String email, required String verifyCode}) =>
      repo.checkForgetPasswordCode(email: email, verifyCode: verifyCode);
}

class ResetPasswordUseCase {
  final BaseAuthRepo repo;
  const ResetPasswordUseCase(this.repo);

  Future<bool> call({
    required String verifyCode,
    required String newPassword,
    required String newPasswordConfirmation,
  }) =>
      repo.resetPassword(
        verifyCode: verifyCode,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
}
