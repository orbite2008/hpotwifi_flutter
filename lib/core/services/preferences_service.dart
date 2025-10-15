// lib/core/services/preferences_service.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

/// Service centralisé pour stocker les préférences utilisateur
class PreferencesService {
  static const _themeKey = 'theme_mode';
  static const _localeKey = 'locale_code';
  static const _firstLaunchKey = 'first_launch';

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

  /// Vérifie si c'est le premier lancement de l'application
  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstLaunchKey) ?? true;
  }

  /// Marque l'application comme déjà lancée
  static Future<void> setNotFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, false);
  }

  /// Méthodes génériques pour gérer toute clé/valeur
  Future<void> setString(String key, String value) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final p = await SharedPreferences.getInstance();
    return p.getString(key);
  }

  Future<void> remove(String key) async {
    final p = await SharedPreferences.getInstance();
    await p.remove(key);
  }

  /// Efface toutes les préférences (utile pour déconnexion complète)
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
