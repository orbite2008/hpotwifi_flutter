// lib/app/providers/global_providers.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/preferences_service.dart';
import '../../core/services/api_client.dart';
import '../../core/services/storage_service.dart';

import '../../features/auth/data/sources/auth_local_source.dart';
import '../../features/auth/data/sources/auth_remote_source.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';

// ========== THEME MODE ==========
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

// ========== LOCALE ==========
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

// ========== SERVICES DE BASE ==========

final storageServiceProvider =
Provider<StorageService>((ref) => StorageService(PreferencesService()));

final httpClientProvider = Provider<ApiClient>((ref) {
  final storage = ref.read(storageServiceProvider);
  return ApiClient(storage: storage);
});

// ========== AUTH DATA SOURCES ==========

final authRemoteSourceProvider = Provider<AuthRemoteSource>(
      (ref) => AuthRemoteSource(ref.read(httpClientProvider)),
);

final authLocalSourceProvider = Provider<AuthLocalSource>(
      (ref) => AuthLocalSource(ref.read(storageServiceProvider)),
);

// ========== AUTH REPOSITORY ==========

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    remote: ref.read(authRemoteSourceProvider),
    local: ref.read(authLocalSourceProvider),
  );
});

// ========== AUTH CONTROLLER ==========

final authControllerProvider =
NotifierProvider<AuthController, AuthState>(AuthController.new);
