// lib/core/constants/app_constants.dart

class AppConstants {
  // Nom et version
  static const String appName = "HpotWifi";
  static const String appVersion = "0.1.0";

  // API
  static const String apiBaseUrl = "http://hpotwifi.testapi.ridcode.com:10100";

  // Durées par défaut
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration splashDelay = Duration(seconds: 2);

  // Espacements
  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
}

class ApiConfig {
  static Uri uri(String path, [Map<String, String>? query]) {
    final base = Uri.parse(AppConstants.apiBaseUrl);

    final normalizedPath = path.startsWith('/') ? path.substring(1) : path;

    return Uri(
      scheme: base.scheme,
      host: base.host,
      port: base.hasPort ? base.port : null,
      path: [
        if (base.path.isNotEmpty) base.path.replaceFirst(RegExp(r'^/'), ''),
        normalizedPath,
      ].where((p) => p.isNotEmpty).join('/'),
      queryParameters: (query == null || query.isEmpty) ? null : query,
    );
  }
}

class AppAssets {
  static const String resetPwd = 'assets/images/passwordreset.png';
}
