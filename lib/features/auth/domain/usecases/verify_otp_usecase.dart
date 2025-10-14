import '../../data/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);

  Future<void> call(String email, String otp) => repository.verifyOtp(email, otp);
}
