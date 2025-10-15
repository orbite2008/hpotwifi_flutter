// lib/features/auth/data/repositories/auth_repository.dart

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

  Future<bool> sendOtp(String email) => remote.sendOtp(email);

  Future<bool> verifyOtp(String email, String otp) =>
      remote.verifyOtp(email, otp);

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
    return model.toEntity();
  }

  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final result = await remote.login(email, password);
    final token = result['token'] as String;
    final user = result['user'] as Map<String, dynamic>;

    await local.saveToken(token);

    final model = UserModel.fromJson(user);
    await local.saveUser(model);

    return model.toEntity();
  }

  /// Vérifie si l'utilisateur a un token valide sauvegardé
  Future<bool> isAuthenticated() async {
    final token = await local.readToken();
    final user = await local.readUser();
    return token != null && token.isNotEmpty && user != null;
  }

  Future<UserEntity?> currentUser() async {
    final m = await local.readUser();
    return m?.toEntity();
  }

  Future<String?> currentToken() => local.readToken();

  Future<void> logout() => local.clear();
}
