// lib/core/services/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import 'storage_service.dart';

class ApiClient {
  final http.Client _http;
  final StorageService _storage;

  ApiClient({
    http.Client? httpClient,
    required StorageService storage,
  })  : _http = httpClient ?? http.Client(),
        _storage = storage;

  Uri buildUri(String path, [Map<String, String>? query]) =>
      ApiConfig.uri(path, query);

  /// GET request
  Future<http.Response> get(
      String path, {
        Map<String, String>? query,
        Map<String, String>? headers,
      }) async {
    final uri = buildUri(path, query);
    final allHeaders = await _baseHeaders(headers);
    return _http.get(uri, headers: allHeaders);
  }

  /// POST request avec JSON
  Future<http.Response> postJson(
      String path,
      Map<String, dynamic> body, {
        Map<String, String>? query,
        Map<String, String>? headers,
      }) async {
    final uri = buildUri(path, query);
    final allHeaders = await _baseHeaders(headers);
    allHeaders.putIfAbsent('Content-Type', () => 'application/json');
    return _http.post(uri, headers: allHeaders, body: jsonEncode(body));
  }

  /// ✅ NOUVEAU : PUT request avec JSON
  Future<http.Response> putJson(
      String path,
      Map<String, dynamic> body, {
        Map<String, String>? query,
        Map<String, String>? headers,
      }) async {
    final uri = buildUri(path, query);
    final allHeaders = await _baseHeaders(headers);
    allHeaders.putIfAbsent('Content-Type', () => 'application/json');
    return _http.put(uri, headers: allHeaders, body: jsonEncode(body));
  }

  /// Charge le token depuis storage et l'ajoute automatiquement
  Future<Map<String, String>> _baseHeaders(Map<String, String>? headers) async {
    final token = await _storage.readToken();

    final baseHeaders = {
      'Accept': 'application/json',
      ...?headers,
    };

    // Ajoute le token JWT si disponible
    if (token != null && token.isNotEmpty) {
      baseHeaders['Authorization'] = 'Bearer $token';
    }

    return baseHeaders;
  }

  void close() => _http.close();
}
