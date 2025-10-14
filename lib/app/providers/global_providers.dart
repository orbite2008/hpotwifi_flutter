import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/preferences_service.dart';
import '../../core/services/api_client.dart';
import '../../core/services/storage_service.dart';

import '../../features/auth/data/sources/auth_local_source.dart';
import '../../features/auth/data/sources/auth_remote_source.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';


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

    state = AsyncData(newMode);
    await PreferencesService.saveThemeMode(newMode);
  }
}

final themeModeProvider =
AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

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

/// Clients & Services de base
final httpClientProvider = Provider<ApiClient>((ref) => ApiClient());
final storageServiceProvider =
Provider<StorageService>((ref) => StorageService(PreferencesService()));

/// Sources de données
final authRemoteSourceProvider = Provider<AuthRemoteSource>(
      (ref) => AuthRemoteSource(ref.read(httpClientProvider)),
);

final authLocalSourceProvider = Provider<AuthLocalSource>(
      (ref) => AuthLocalSource(ref.read(storageServiceProvider)),
);

/// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    remote: ref.read(authRemoteSourceProvider),
    local: ref.read(authLocalSourceProvider),
  );
});

/// Controller (nouveau système NotifierProvider)
final authControllerProvider =
NotifierProvider<AuthController, AuthState>(AuthController.new);
