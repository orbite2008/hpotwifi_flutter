// lib/core/services/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
// import '../constants/api_paths.dart';  // on l'importera au moment d'utiliser des endpoints

class ApiClient {
  final http.Client _http;
  ApiClient({http.Client? httpClient}) : _http = httpClient ?? http.Client();

  Uri buildUri(String path, [Map<String, String>? query]) =>
      ApiConfig.uri(path, query);

  Future<http.Response> get(
      String path, {
        Map<String, String>? query,
        Map<String, String>? headers,
      }) {
    final uri = buildUri(path, query);
    return _http.get(uri, headers: _baseHeaders(headers));
  }

  Future<http.Response> postJson(
      String path,
      Map<String, dynamic> body, {
        Map<String, String>? query,
        Map<String, String>? headers,
      }) {
    final uri = buildUri(path, query);
    final allHeaders = _baseHeaders(headers)
      ..putIfAbsent('Content-Type', () => 'application/json');
    return _http.post(uri, headers: allHeaders, body: jsonEncode(body));
  }

  Map<String, String> _baseHeaders(Map<String, String>? headers) {
    return {
      'Accept': 'application/json',
      ...?headers,
    };
  }

  void close() => _http.close();
}
