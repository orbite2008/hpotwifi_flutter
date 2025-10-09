import 'package:flutter/material.dart';

/// 🎨 Thème adaptatif clair/sombre
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
  final Color error;

  // Spécifiques aux hotspots
  final Color cardBackground;
  final Color cardBorder;
  final Color statusActive;
  final Color separatorLight;

  // Couleurs de badge (rôle)
  final Color ownerBadge;
  final Color assistantBadge;

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
    required this.error,
    required this.cardBackground,
    required this.cardBorder,
    required this.statusActive,
    required this.separatorLight,
    required this.ownerBadge,
    required this.assistantBadge,
  });

  /// Palette claire
  static const light = AppColors(
    primary: Color(0xFF0C60AF),
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
    error: Color(0xFFE53935),

    // Hotspots
    cardBackground: Color(0xFFF2F6FF),
    cardBorder: Color(0xFF685DFF),
    statusActive: Color(0xFF4CAF50),
    separatorLight: Color(0x1A000000),

    // Badges
    ownerBadge: Color(0xFF9AC3FF),
    assistantBadge: Color(0xFFB0B0B0),
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
    error: Color(0xFFEF5350),

    // Hotspots
    cardBackground: Color(0xFF1E1E2E),
    cardBorder: Color(0xFF685DFF),
    statusActive: Color(0xFF4CAF50),
    separatorLight: Color(0x1AFFFFFF),

    // Badges
    ownerBadge: Color(0xFF5C8EDC),
    assistantBadge: Color(0xFF666666),
  );

  /// Sélecteur de palette selon le thème
  static AppColors of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? dark : light;
  }
}

/// Rayon standard
class AppRadius {
  static const double small = 8.0;
  static const double medium = 14.0;
  static const double large = 20.0;
}

/// Marges standard
class AppPadding {
  static const double small = 8.0;
  static const double normal = 16.0;
  static const double large = 24.0;
}

/// Styles de texte standard
class AppTextStyles {
  static const TextStyle body = TextStyle(fontSize: 15);
  static const TextStyle hint = TextStyle(fontSize: 15);
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
