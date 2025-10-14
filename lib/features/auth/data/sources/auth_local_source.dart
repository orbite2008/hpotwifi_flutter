import '../models/user_model.dart';
import '../../../../core/services/storage_service.dart';

class AuthLocalSource {
  final StorageService _storage;
  AuthLocalSource(this._storage);

  Future<void> saveUser(UserModel user) async {
    await _storage.saveUserJson(user.toJson());
  }

  Future<UserModel?> readUser() async {
    final json = await _storage.readUserJson();
    if (json == null) return null;
    return UserModel.fromJson(json);
  }

  Future<void> saveToken(String token) => _storage.saveToken(token);
  Future<String?> readToken()          => _storage.readToken();

  Future<void> clear() => _storage.clearAll();
}
