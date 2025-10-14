import '../../data/repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class RegisterUserUseCase {
  final AuthRepository repository;
  RegisterUserUseCase(this.repository);

  Future<UserEntity> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phonenumber,
    required String city,
    required String countryCode,
  }) {
    return repository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phonenumber: phonenumber,
      city: city,
      countryCode: countryCode,
    );
  }
}
