import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/otp_dialog.dart';

class RegisterEmailPage extends ConsumerStatefulWidget {
  const RegisterEmailPage({super.key});

  @override
  ConsumerState<RegisterEmailPage> createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends ConsumerState<RegisterEmailPage> {
  final _emailController = TextEditingController();
  String? _emailError;
  bool _filled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _filled = _emailController.text.trim().isNotEmpty;
        _emailError = null;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onContinue() async {
    final loc = AppLocalizations.of(context)!;
    FocusScope.of(context).unfocus();

    // Validation centralisée
    final emailError =
    FormValidators.validateEmail(context, _emailController.text);

    if (emailError != null) {
      setState(() => _emailError = emailError);
      return;
    }

    // Affiche le loader localisé
    await showAppLoader(context, message: loc.loading);
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.of(context).pop(); // Ferme le loader

    // Affiche le dialogue OTP
    await showOtpDialog(context, _emailController.text.trim());
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
            // 🔹 Titre principal
            Text(
              loc.signupCreateAccountTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            // 🔹 Sous-titre
            Text(
              loc.signupEnterEmailSubtitle,
              style: TextStyle(
                fontSize: 15,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),

            // 🔹 Champ e-mail avec validation
            AppTextField.email(
              controller: _emailController,
              errorText: _emailError,
              hint: loc.emailLabel,
            ),

            const SizedBox(height: 24),

            // 🔹 Bouton continuer
            AppButton(
              label: loc.continueBtn,
              onPressed: _filled ? _onContinue : null,
              enabled: _filled,
              backgroundColor:
              _filled ? colors.buttonActive : colors.buttonInactive,
            ),

            const SizedBox(height: 20),

            // 🔹 Lien vers la connexion
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  loc.signupHaveAccount,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 15,
                  ),
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
