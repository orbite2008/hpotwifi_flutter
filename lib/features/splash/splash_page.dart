// lib/features/splash/splash_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hpotwifi/core/constants/app_constants.dart';
import '../../core/services/preferences_service.dart';
import '../../core/theme/app_styles.dart';
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
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final authController = ref.read(authControllerProvider.notifier);
    final isAuthenticated = await authController.checkAuthStatus();
    final isFirstLaunch = await PreferencesService.isFirstLaunch();

    if (!mounted) return;

    if (isAuthenticated) {
      context.goNamed('home');
    } else if (isFirstLaunch) {
      await PreferencesService.setNotFirstLaunch();
      context.goNamed('registerEmail');
    } else {
      context.goNamed('login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // Logo centré
          Center(
            child: Icon(
              Icons.wifi,
              size: 120,
              color: colors.primary,
            ),
          ),

          // Loader en bas centré
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: Center(
              child: CircularProgressIndicator(
                color: colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
