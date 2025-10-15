// lib/features/auth/data/sources/auth_remote_source.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_paths.dart';
import '../../../../core/services/api_client.dart';
import '../../../../core/services/api_exception.dart';

class AuthRemoteSource {
  final ApiClient _client;

  AuthRemoteSource(this._client);

  /// Envoie un code OTP à l’adresse e-mail fournie.
  Future<bool> sendOtp(String email) async {
    final res = await _client.postJson(ApiPaths.sendOtp, {"email": email});
    final body = _checkResponse(res, expected: {200});

    if (body['success'] != true) {
      final message = body['message']?.toString() ?? 'Échec de l’envoi du code OTP';
      throw ApiException(message, statusCode: res.statusCode);
    }
    return true;
  }

  /// Vérifie un code OTP pour un e-mail donné.
  Future<bool> verifyOtp(String email, String otp) async {
    final res = await _client.postJson(ApiPaths.verifyOtp, {
      "email": email,
      "otp": otp,
    });
    final body = _checkResponse(res, expected: {200});

    if (body['success'] != true) {
      final message = body['message']?.toString() ?? 'OTP invalide ou expiré';
      throw ApiException(message, statusCode: res.statusCode);
    }
    return true;
  }

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> payload) async {
    final res = await _client.postJson(ApiPaths.register, payload);
    final body = _checkResponse(res, expected: {201});

    final user = body['user'];
    if (user is Map<String, dynamic>) {
      return user;
    }
    throw ApiException(
      'Réponse invalide: champ "user" absent',
      statusCode: res.statusCode,
    );
  }

  /// Authentifie un utilisateur et renvoie son token et ses infos.
  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await _client.postJson(ApiPaths.login, {
      "email": email,
      "password": password,
    });
    final body = _checkResponse(res, expected: {200});

    // Tolérance selon le format du backend
    Map<String, dynamic> data = body;
    if (body['data'] is Map<String, dynamic>) {
      data = body['data'] as Map<String, dynamic>;
    }

    final token = (data['token'] ?? data['accessToken'])?.toString();
    final user = data['user'];

    if (token == null || user is! Map<String, dynamic>) {
      throw ApiException('Réponse invalide de /user/login', statusCode: res.statusCode);
    }

    return {'token': token, 'user': user};
  }

  /// Vérifie et décode proprement la réponse HTTP.
  Map<String, dynamic> _checkResponse(http.Response res, {required Set<int> expected}) {
    final status = res.statusCode;
    Map<String, dynamic>? json;

    try {
      json = res.body.isEmpty ? <String, dynamic>{} : jsonDecode(res.body);
    } catch (_) {
      throw ApiException('Réponse JSON invalide', statusCode: status);
    }

    // Réponses attendues (succès)
    if (expected.contains(status)) return json!;

    // Erreurs côté client (400-499)
    if (status >= 400 && status < 500) {
      throw ApiException.fromResponse(json, status);
    }

    // Erreurs serveur (500+)
    if (status >= 500) {
      throw ApiException('Erreur serveur interne', statusCode: status);
    }

    // Cas inattendu
    throw ApiException('Erreur inconnue', statusCode: status);
  }
}
