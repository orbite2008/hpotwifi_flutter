// lib/features/splash/splash_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/preferences_service.dart';
import '../auth/presentation/controllers/auth_controller.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Délai pour afficher le splash (optionnel)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final authController = ref.read(authControllerProvider.notifier);
    final isAuthenticated = await authController.checkAuthStatus();
    final isFirstLaunch = await PreferencesService.isFirstLaunch();

    if (!mounted) return;

    if (isAuthenticated) {
      // Utilisateur connecté → Home
      context.goNamed('home');
    } else if (isFirstLaunch) {
      // Première ouverture → Register
      await PreferencesService.setNotFirstLaunch();
      context.goNamed('registerEmail');
    } else {
      // Déjà utilisé → Login
      context.goNamed('login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo de votre app
            Icon(
              Icons.wifi_tethering,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            const Text('Chargement...'),
          ],
        ),
      ),
    );
  }
}
