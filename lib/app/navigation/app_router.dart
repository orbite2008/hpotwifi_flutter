// lib/app/router/app_router.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/preferences_service.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/splash/splash_page.dart';
import '../../features/home/domain/entities/hotspot_entity.dart';
import '../../features/home/presentation/pages/add_hotspot_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/hotspot_detail_page.dart';
import '../../features/presentation/pages/settings_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/auth/presentation/pages/reset_success_page.dart';
import '../../features/auth/presentation/pages/register_email_page.dart';
import '../../features/auth/presentation/pages/register_details_page.dart';
import '../../features/auth/presentation/pages/register_password_page.dart';

// --- Placeholders pages simples ---
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) async {
      if (state.matchedLocation == '/splash') {
        return null;
      }

      final authController = ref.read(authControllerProvider.notifier);
      final isAuthenticated = await authController.checkAuthStatus();

      final publicRoutes = [
        '/login',
        '/auth/register-email',
        '/auth/register-details',
        '/auth/register-password',
        '/auth/reset-password',
        '/auth/reset-success',
      ];

      final isPublicRoute = publicRoutes.any((route) =>
          state.matchedLocation.startsWith(route)
      );

      if (isAuthenticated && isPublicRoute) {
        return '/';
      }

      if (!isAuthenticated && !isPublicRoute) {
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (_, __) => const SplashPage(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (_, __) => const SettingsPage(),
      ),

      // Auth
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: '/auth/register-email',
        name: 'registerEmail',
        builder: (_, __) => const RegisterEmailPage(),
      ),
      GoRoute(
        path: '/auth/register-details',
        name: 'registerDetails',
        builder: (_, __) => const RegisterDetailsPage(),
      ),
      GoRoute(
        path: '/auth/register-password',
        name: 'registerPassword',
        builder: (_, __) => const RegisterPasswordPage(),
      ),
      GoRoute(
        path: '/auth/reset-password',
        name: 'resetPassword',
        builder: (_, __) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: '/auth/reset-success',
        name: 'resetSuccess',
        builder: (_, __) => const ResetSuccessPage(),
      ),

      // Pages du menu
      GoRoute(
        path: '/add-hotspot',
        name: 'addHotspot',
        builder: (context, state) => const AddHotspotPage(),
      ),
      GoRoute(
        path: '/tickets',
        name: 'tickets',
        builder: (_, __) => const PlaceholderPage(title: 'Gestion des tickets'),
      ),
      GoRoute(
        path: '/sellers',
        name: 'sellers',
        builder: (_, __) => const PlaceholderPage(title: 'Mes vendeurs'),
      ),
      GoRoute(
        path: '/report',
        name: 'report',
        builder: (_, __) => const PlaceholderPage(title: 'Rapport'),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (_, __) => const PlaceholderPage(title: 'Mon profil'),
      ),
      GoRoute(
        path: '/hotspot-detail',
        name: 'hotspotDetail',
        builder: (context, state) {
          final hotspot = state.extra as HotspotEntity?;
          return HotspotDetailPage(hotspot: hotspot);
        },
      ),
    ],
  );
});
