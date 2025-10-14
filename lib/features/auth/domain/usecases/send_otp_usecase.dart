import '../../data/repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository repository;
  SendOtpUseCase(this.repository);

  Future<void> call(String email) => repository.sendOtp(email);
}
