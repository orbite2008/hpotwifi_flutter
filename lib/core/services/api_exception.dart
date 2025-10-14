/// Exception normalisée pour toutes les erreurs API
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final Object? cause;

  ApiException(this.message, {this.statusCode, this.cause});

  @override
  String toString() => 'ApiException($statusCode): $message';

  static ApiException fromResponse(Map<String, dynamic>? json, int? status) {
    final msg = json?['message'] ?? json?['error'] ?? 'Erreur inconnue du serveur';
    return ApiException(msg.toString(), statusCode: status);
  }
}
