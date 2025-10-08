import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/presentation/pages/home_page.dart';
import '../../../features/presentation/pages/settings_page.dart';
import '../../../features/auth/presentation/pages/register_email_page.dart';
import '../../../features/auth/presentation/pages/register_details_page.dart';
import '../../../features/auth/presentation/pages/register_password_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/auth/register-email',
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
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const _LoginPlaceholder(),
      ),
    ],
  );
});

class _LoginPlaceholder extends StatelessWidget {
  const _LoginPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Page de connexion (à implémenter)', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
