import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/presentation/pages/home_page.dart';
import '../../features/presentation/pages/settings_page.dart';
import '../../features/auth/presentation/pages/register_email_page.dart';
import '../../features/auth/presentation/pages/register_details_page.dart';
import '../../features/auth/presentation/pages/register_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart'; // NOUVEAU

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login', // Changer pour commencer sur login
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      
      // Route de connexion
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      
      // Routes d'inscription
      GoRoute(
        path: '/auth/register-email',
        name: 'registerEmail',
        builder: (context, state) => const RegisterEmailPage(),
      ),
      GoRoute(
        path: '/auth/register-details',
        name: 'registerDetails',
        builder: (context, state) => const RegisterDetailsPage(),
      ),
      GoRoute(
        path: '/auth/register-password',
        name: 'registerPassword',
        builder: (context, state) => const RegisterPasswordPage(),
      ),
    ],
  );
});
