import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/presentation/pages/home_page.dart';
import '../../../features/presentation/pages/settings_page.dart';
import '../../../features/auth/presentation/pages/register_email_page.dart';

/// Provider global pour GoRouter (Riverpod)
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/auth/register-email',
    routes: [
      // 🏠 Page d’accueil
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      // ⚙️ Paramètres
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),

      // 📧 Étape 1 : saisie de l'email
      GoRoute(
        path: '/auth/register-email',
        name: 'registerEmail',
        builder: (context, state) => const RegisterEmailPage(),
      ),

      // 🧩 Étape 2 : détails d’inscription (après validation OTP)
      GoRoute(
        path: '/auth/register-details',
        name: 'registerDetails',
        builder: (context, state) => const _RegisterDetailsPlaceholder(),
      ),

      // 🔐 Placeholder temporaire pour la page de connexion
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const _LoginPlaceholder(),
      ),
    ],
  );
});

/// --- PLACEHOLDER LOGIN ---
class _LoginPlaceholder extends StatelessWidget {
  const _LoginPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Login page (à implémenter)',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class _RegisterDetailsPlaceholder extends StatelessWidget {
  const _RegisterDetailsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Page Détails Inscription (prochaine étape)',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
