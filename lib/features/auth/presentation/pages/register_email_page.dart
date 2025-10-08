import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/otp_dialog.dart';
import 'package:go_router/go_router.dart';

class RegisterEmailPage extends ConsumerStatefulWidget {
  const RegisterEmailPage({super.key});

  @override
  ConsumerState<RegisterEmailPage> createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends ConsumerState<RegisterEmailPage> {
  final _email = TextEditingController();
  bool _filled = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _email.addListener(() {
      setState(() {
        _filled = _email.text.trim().isNotEmpty;
        _errorMessage = null;
      });
    });
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  bool _isValidEmail(String input) {
    const pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$";
    return RegExp(pattern).hasMatch(input);
  }

  Future<void> _onContinue() async {
    final loc = AppLocalizations.of(context)!;
    final email = _email.text.trim();
    FocusScope.of(context).unfocus();

    if (!_isValidEmail(email)) {
      setState(() {
        _errorMessage = loc.signupInvalidEmail;
      });
      return;
    }

    // Loader localisé
    await showAppLoader(context, message: loc.loading);
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.of(context).pop(); // ferme le loader

    await showOtpDialog(context, email);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AuthAppBar(title: loc.appTitle),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre principal
            Text(
              loc.signupCreateAccountTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            // Sous-titre
            Text(
              loc.signupEnterEmailSubtitle,
              style: TextStyle(fontSize: 15, color: colors.textSecondary),
            ),
            const SizedBox(height: 32),

            // Champ e-mail avec erreur localisée
            AppTextField.email(
              controller: _email,
              errorText: _errorMessage,
            ),

            const SizedBox(height: 24),

            // Bouton continuer
            AppButton(
              label: loc.continueBtn,
              onPressed: _filled ? _onContinue : null,
              enabled: _filled,
              backgroundColor:
              _filled ? colors.buttonActive : colors.buttonInactive,
            ),

            const SizedBox(height: 20),

            // Lien vers la connexion
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  loc.signupHaveAccount,
                  style: TextStyle(color: colors.textSecondary, fontSize: 15),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => context.goNamed('login'),
                  child: Text(
                    loc.loginLink,
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
