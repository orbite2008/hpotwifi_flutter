import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_paths.dart';
import '../../../../core/services/api_client.dart';
import '../../../../core/services/api_exception.dart';

class AuthRemoteSource {
  final ApiClient _client;
  AuthRemoteSource(this._client);

  Future<void> sendOtp(String email) async {
    final res = await _client.postJson(ApiPaths.sendOtp, {"email": email});
    _checkResponse(res, expected: {200});
  }

  Future<void> verifyOtp(String email, String otp) async {
    final res = await _client.postJson(ApiPaths.verifyOtp, {
      "email": email,
      "otp": otp,
    });
    _checkResponse(res, expected: {200});
  }

  /// Register renvoie 201 + { message, success, user: {...} }
  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> payload) async {
    final res = await _client.postJson(ApiPaths.register, payload);
    final body = _checkResponse(res, expected: {201});
    final user = body['user'];
    if (user is Map<String, dynamic>) return user;
    throw ApiException('Réponse invalide: champ "user" absent', statusCode: res.statusCode);
  }

  /// Login (si disponible):
  /// - On tolère plusieurs formes de réponse: {token, user} ou {accessToken, user} ou {success, data:{token, user}}
  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await _client.postJson(ApiPaths.login, {
      "email": email,
      "password": password,
    });
    final body = _checkResponse(res, expected: {200});

    // extraction tolérante
    Map<String, dynamic> data = body;
    if (body['data'] is Map<String, dynamic>) {
      data = body['data'] as Map<String, dynamic>;
    }

    final token = (data['token'] ?? data['accessToken'])?.toString();
    final user  = data['user'];

    if (token == null || user is! Map<String, dynamic>) {
      throw ApiException('Réponse invalide de /user/login', statusCode: res.statusCode);
    }
    return {'token': token, 'user': user};
  }

  Map<String, dynamic> _checkResponse(http.Response res, {required Set<int> expected}) {
    final status = res.statusCode;
    Map<String, dynamic>? json;
    try {
      json = res.body.isEmpty ? <String, dynamic>{} : jsonDecode(res.body);
    } catch (_) {
      throw ApiException('Réponse JSON invalide', statusCode: status);
    }

    if (expected.contains(status)) return json!;

    if (status >= 400 && status < 500) {
      throw ApiException.fromResponse(json, status);
    } else if (status >= 500) {
      throw ApiException('Erreur serveur interne', statusCode: status);
    }
    throw ApiException('Erreur inconnue', statusCode: status);
  }
}
