import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/gestures.dart'; // Pour TapGestureRecognizer
import 'package:hpotwifi/features/auth/presentation/widgets/forgot_password_dialog.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../l10n/app_localizations.dart';

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
  String? _generalError;

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
      _filled =
          _emailController.text.trim().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty;
      // Réinitialiser les erreurs quand l'utilisateur tape
      _emailError = null;
      _passwordError = null;
      _generalError = null;
    });
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> _onLogin() async {
    final loc = AppLocalizations.of(context)!;

    // Fermer le clavier
    FocusScope.of(context).unfocus();

    // Réinitialiser les erreurs
    setState(() {
      _emailError = null;
      _passwordError = null;
      _generalError = null;
    });

    // Récupérer et nettoyer les valeurs
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Validations
    if (email.isEmpty) {
      setState(() {
        _emailError = loc.emailRequired;
      });
      return;
    }

    if (!_isValidEmail(email)) {
      setState(() {
        _emailError = loc.signupInvalidEmail;
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = loc.passwordRequired;
      });
      return;
    }

    // Afficher le loader
    showAppLoader(context, message: loc.loading);

    // Simuler un appel API (1.5 secondes)
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    // Fermer le loader
    Navigator.pop(context);

    // Simulation : Si email contient "test" et password contient "pass", succès
    if (email.toLowerCase().contains('test') &&
        password.toLowerCase().contains('pass')) {
      // Succès - navigation vers home
      if (!mounted) return;

      // Afficher message de succès (optionnel)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.loginSuccess),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigation vers la page d'accueil
      context.goNamed('home');
    } else {
      // Échec - afficher erreur
      setState(() {
        _generalError = loc.invalidCredentials;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AuthAppBar(title: loc.appTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Titre
            Text(
              loc.loginTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            // Sous-titre
            Text(
              loc.loginSubtitle,
              style: TextStyle(fontSize: 15, color: colors.textSecondary),
            ),

            const SizedBox(height: 32),

            // Champ Email
            AppTextField.email(
              controller: _emailController,
              errorText: _emailError,
              hint: loc.emailLabel,
            ),

            const SizedBox(height: 16),

            // Champ Mot de passe
            AppTextField.password(
              controller: _passwordController,
              errorText: _passwordError,
              hint: loc.passwordLabel,
            ),

            const SizedBox(height: 12),

            // Mot de passe oublié
            // Mot de passe oublié
            // Mot de passe oublié
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => showForgotPasswordDialog(context),
                child: Text(
                  loc.forgotPassword,
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // Message d'erreur général
            if (_generalError != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.small),
                  border: Border.all(
                    color: colors.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: colors.error, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _generalError!,
                        style: TextStyle(color: colors.error, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 32),

            // Bouton Connexion
            AppButton(
              label: loc.loginBtn,
              onPressed: _filled ? _onLogin : null,
              enabled: _filled,
              backgroundColor:
                  _filled ? colors.buttonActive : colors.buttonInactive,
            ),

            const SizedBox(height: 24),

            // Lien vers inscription - ALIGNÉ À GAUCHE
            Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 15, color: colors.textSecondary),
                children: [
                  TextSpan(text: '${loc.noAccount} '),
                  TextSpan(
                    text: loc.signupLink,
                    style: TextStyle(
                      color: colors.buttonActive,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () => context.goNamed('registerEmail'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
