// lib/core/services/preferences_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

/// Service centralisé pour stocker les préférences utilisateur
class PreferencesService {
  static const _themeKey = 'theme_mode';
  static const _localeKey = 'locale_code';

  /// Sauvegarde le mode de thème choisi
  static Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  /// Charge le mode de thème sauvegardé
  static Future<ThemeMode> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_themeKey);
    return switch (name) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  /// Sauvegarde la langue actuelle
  static Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  /// Charge la langue sauvegardée (ou 'fr' par défaut)
  static Future<Locale> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey) ?? 'fr';
    return Locale(code);
  }
}
