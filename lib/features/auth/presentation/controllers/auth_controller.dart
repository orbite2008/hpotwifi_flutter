// lib/features/auth/presentation/controllers/auth_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/providers/global_providers.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import '../../../../core/services/api_exception.dart';

class AuthState {
  final bool loading;
  final String? errorMessage;

  const AuthState({
    this.loading = false,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? loading,
    String? errorMessage,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      errorMessage: errorMessage,
    );
  }

  static const initial = AuthState();
}

class AuthController extends Notifier<AuthState> {
  late final AuthRepository _repo;

  @override
  AuthState build() {
    _repo = ref.read(authRepositoryProvider);
    return AuthState.initial;
  }

  Future<bool> sendOtp(String email) async {
    return _guard(() => _repo.sendOtp(email));
  }

  Future<bool> verifyOtp(String email, String otp) async {
    return _guard(() => _repo.verifyOtp(email, otp));
  }

  /// Inscription : ne sauvegarde PAS localement (pas de token dans la réponse API)
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phonenumber,
    required String city,
    required String countryCode,
  }) async {
    return _guard(() => _repo.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phonenumber: phonenumber,
      city: city,
      countryCode: countryCode,
    ));
  }

  /// Connexion : sauvegarde token + user localement
  Future<bool> login(String email, String password) async {
    return _guard(() => _repo.login(email: email, password: password));
  }

  Future<void> logout() async {
    await _repo.logout();
    state = AuthState.initial; // Réinitialise l'état après déconnexion
  }

  /// Gestion d'état centralisée avec gestion d'erreur
  Future<bool> _guard(Future<dynamic> Function() fn) async {
    state = state.copyWith(loading: true, errorMessage: null);
    try {
      await fn();
      state = state.copyWith(loading: false, errorMessage: null);
      return true;
    } on ApiException catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(
        loading: false,
        errorMessage: 'Erreur inattendue: ${e.toString()}',
      );
      return false;
    }
  }
}

final authControllerProvider =
NotifierProvider<AuthController, AuthState>(AuthController.new);
