// lib/app/providers/global_providers.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/preferences_service.dart';

/// GESTION DU THÈME
class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    return await PreferencesService.loadThemeMode();
  }

  Future<void> toggle() async {
    final current = state.value ?? ThemeMode.system;

    final newMode = switch (current) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
      _ => ThemeMode.dark,
    };

    // Met à jour la valeur localement + persistance
    state = AsyncData(newMode);
    await PreferencesService.saveThemeMode(newMode);
  }
}

final themeModeProvider =
AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);


/// GESTION DE LA LANGUE
class LocaleNotifier extends AsyncNotifier<Locale> {
  @override
  Future<Locale> build() async {
    return await PreferencesService.loadLocale();
  }

  Future<void> toggle() async {
    final current = state.value ?? const Locale('fr');
    final newLocale =
    current.languageCode == 'fr' ? const Locale('en') : const Locale('fr');

    state = AsyncData(newLocale);
    await PreferencesService.saveLocale(newLocale);
  }
}

final localeProvider =
AsyncNotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);
