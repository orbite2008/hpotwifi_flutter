import 'package:flutter/material.dart';

/// Thème adaptatif clair/sombre
class AppColors {
  final Color primary;
  final Color background;
  final Color surface;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color hint;
  final Color disabled;
  final Color inputFill;
  final Color buttonInactive;
  final Color buttonActive;

  const AppColors({
    required this.primary,
    required this.background,
    required this.surface,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.hint,
    required this.disabled,
    required this.inputFill,
    required this.buttonInactive,
    required this.buttonActive,
  });

  /// Palette claire
  static const light = AppColors(
    primary: Color(0xFF7DAAEF),
    background: Color(0xFFF9F9F9),
    surface: Colors.white,
    border: Color(0xFFE0E0E0),
    textPrimary: Color(0xFF1C1C1C),
    textSecondary: Color(0xFF6E6E6E),
    hint: Color(0xFF9E9E9E),
    disabled: Color(0xFFDADADA),
    inputFill: Colors.white,
    buttonInactive: Color(0xFF86ACD7),
    buttonActive: Color(0xFF0C60AF),
  );

  /// Palette sombre
  static const dark = AppColors(
    primary: Color(0xFF7DAAEF),
    background: Color(0xFF0F0F0F),
    surface: Color(0xFF1C1C1C),
    border: Color(0xFF333333),
    textPrimary: Colors.white,
    textSecondary: Color(0xFFBDBDBD),
    hint: Color(0xFF888888),
    disabled: Color(0xFF444444),
    inputFill: Color(0xFF1C1C1C),
    buttonInactive: Color(0xFF86ACD7),
    buttonActive: Color(0xFF0C60AF),
  );

  /// Récupère la palette en fonction du thème actif
  static AppColors of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? dark : light;
  }
}

class AppRadius {
  static const double small = 8.0;
  static const double medium = 14.0;
  static const double large = 20.0;
}

class AppPadding {
  static const double small = 8.0;
  static const double normal = 16.0;
  static const double large = 24.0;
}

class AppTextStyles {
  static const TextStyle body = TextStyle(fontSize: 15);
  static const TextStyle hint = TextStyle(fontSize: 15);
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
