import 'dart:convert';
import 'preferences_service.dart';

class StorageService {
  StorageService(this._prefs);

  final PreferencesService _prefs;

  static const _keyAuthToken = 'auth_token';
  static const _keyUserData  = 'user_data';

  Future<void> saveToken(String token) => _prefs.setString(_keyAuthToken, token);
  Future<String?> readToken()           => _prefs.getString(_keyAuthToken);
  Future<void> clearToken()             => _prefs.remove(_keyAuthToken);

  Future<void> saveUserJson(Map<String, dynamic> json) =>
      _prefs.setString(_keyUserData, jsonEncode(json));
  Future<Map<String, dynamic>?> readUserJson() async {
    final str = await _prefs.getString(_keyUserData);
    if (str == null) return null;
    try {
      return jsonDecode(str) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> clearUser() => _prefs.remove(_keyUserData);

  Future<void> clearAll() async {
    await clearToken();
    await clearUser();
  }
}
