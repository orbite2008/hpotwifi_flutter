// lib/core/constants/api_paths.dart

class ApiPaths {
  // OTP
  static const String sendOtp   = "/user/send-otp";
  static const String verifyOtp = "/user/verify-otp";

  // Inscription & connexion
  static const String register  = "/user/register";
  static const String login = '/auth/login';

  // Hotspots
  static const String listHotspot = '/hotspot/listHotspot';
  static const String createHotspot = '/hotspot/createHotspot';
  static const String getHotspot = '/hotspot/getHotspot';

  // ✅ Méthodes existantes
  static String getHotspotById(int id) => '$getHotspot/$id';

  // ✅ NOUVEAU : Édition hotspot
  static String editHotspot(int id) => '/hotspot/editHotspot/$id';
}
