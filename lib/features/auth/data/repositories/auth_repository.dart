import '../sources/auth_remote_source.dart';
import '../sources/auth_local_source.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthRemoteSource remote;
  final AuthLocalSource local;

  AuthRepository({
    required this.remote,
    required this.local,
  });

  // OTP
  Future<void> sendOtp(String email) => remote.sendOtp(email);
  Future<void> verifyOtp(String email, String otp) => remote.verifyOtp(email, otp);

  // Register
  Future<UserEntity> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phonenumber,
    required String city,
    required String countryCode,
  }) async {
    final userJson = await remote.registerUser({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "phonenumber": phonenumber,
      "city": city,
      "countryCode": countryCode,
    });

    final model = UserModel.fromJson(userJson);
    await local.saveUser(model);
    return model.toEntity();
  }

  // Login
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final result = await remote.login(email, password);
    final token = result['token'] as String;
    final user  = result['user']  as Map<String, dynamic>;

    final model = UserModel.fromJson(user);
    await local.saveToken(token);
    await local.saveUser(model);

    return model.toEntity();
  }

  // Local helpers
  Future<UserEntity?> currentUser() async {
    final m = await local.readUser();
    return m?.toEntity();
  }

  Future<String?> currentToken() => local.readToken();

  Future<void> logout() => local.clear();
}
