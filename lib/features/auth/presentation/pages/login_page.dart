// lib/features/auth/presentation/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/providers/global_providers.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/forgot_password_dialog.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _filled = false;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkFilled);
    _passwordController.addListener(_checkFilled);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _checkFilled() {
    setState(() {
      _filled = _emailController.text.trim().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty;
      _emailError = null;
      _passwordError = null;
    });
  }

  Future<void> _onLogin() async {
    final loc = AppLocalizations.of(context)!;
    FocusScope.of(context).unfocus();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final emailError = FormValidators.validateEmail(context, email);
    if (emailError != null) {
      setState(() => _emailError = emailError);
      return;
    }

    final passwordError = FormValidators.validatePassword(context, password);
    if (passwordError != null) {
      setState(() => _passwordError = passwordError);
      return;
    }

    final authController = ref.read(authControllerProvider.notifier);
    await showAppLoader(context, message: loc.loading);

    final success = await authController.login(email, password);

    if (!mounted) return;
    Navigator.of(context).pop(); // Ferme le loader

    if (success) {
      context.goNamed('home');
    } else {
      final state = ref.read(authControllerProvider);
      setState(() => _passwordError = state.errorMessage ?? loc.invalidCredentials);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AuthAppBar(title: loc.appTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.loginTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              loc.loginSubtitle,
              style: TextStyle(fontSize: 15, color: colors.textSecondary),
            ),
            const SizedBox(height: 32),
            AppTextField.email(
              controller: _emailController,
              errorText: _emailError,
              hint: loc.emailLabel,
            ),
            const SizedBox(height: 16),
            AppTextField.password(
              controller: _passwordController,
              errorText: _passwordError,
              hint: loc.passwordLabel,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => showForgotPasswordDialog(context),
                child: Text(
                  loc.forgotPassword,
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.buttonActive,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: loc.loginBtn,
              enabled: _filled,
              onPressed: _filled ? _onLogin : null,
              backgroundColor:
              _filled ? colors.buttonActive : colors.buttonInactive,
            ),
            const SizedBox(height: 24),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  loc.noAccount,
                  style: TextStyle(color: colors.textSecondary, fontSize: 15),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => context.goNamed('registerEmail'),
                  child: Text(
                    loc.signupLink,
                    style: TextStyle(
                      color: colors.buttonActive,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
