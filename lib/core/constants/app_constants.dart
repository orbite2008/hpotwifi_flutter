// lib/core/constants/app_constants.dart

/// Contient toutes les constantes globales de l'application Hotspot Wifi
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

/// Chemins d'API centralisés
class ApiPaths {
  static const String register       = "/user/register";
}

/// Config réseau commune
class ApiConfig {

  static Uri uri(String path, [Map<String, String>? query]) {
    final base = "${AppConstants.apiBaseUrl}$path";
    final parsed = Uri.parse(base);
    return query == null ? parsed : parsed.replace(queryParameters: query);
  }
}

class AppAssets {
  static const String resetPwd = 'assets/images/passwordreset.png';
}
