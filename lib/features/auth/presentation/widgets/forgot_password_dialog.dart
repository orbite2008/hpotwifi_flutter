import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../l10n/app_localizations.dart';

/// Affiche le dialogue de mot de passe oublié
Future<void> showForgotPasswordDialog(BuildContext context) async {
  final colors = AppColors.of(context);
  final loc = AppLocalizations.of(context)!;
  
  final controller = TextEditingController();
  bool filled = false;
  String? errorText;

  void updateFilled(StateSetter setState) {
    setState(() {
      filled = controller.text.trim().isNotEmpty;
      errorText = null;
    });
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> sendResetLink(
    BuildContext dialogContext,
    StateSetter setState,
  ) async {
    final email = controller.text.trim();

    // Fermer le clavier
    FocusScope.of(dialogContext).unfocus();

    // Validation email
    if (email.isEmpty) {
      setState(() {
        errorText = loc.emailRequired;
      });
      return;
    }

    if (!isValidEmail(email)) {
      setState(() {
        errorText = loc.signupInvalidEmail;
      });
      return;
    }

    // Afficher le loader
    showAppLoader(dialogContext, message: loc.loading);

    // Simuler un appel API (2 secondes)
    await Future.delayed(const Duration(seconds: 2));

    if (!dialogContext.mounted) return;

    // Fermer le loader
    Navigator.pop(dialogContext);

    // Fermer le dialogue
    Navigator.pop(dialogContext);

    // Afficher message de succès
    if (dialogContext.mounted) {
      ScaffoldMessenger.of(dialogContext).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.resetLinkSent,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                loc.checkYourEmail,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          controller.addListener(() => updateFilled(setState));

          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              backgroundColor: colors.surface.withValues(alpha: 0.97),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.large),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.large),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // En-tête avec logo et bouton fermer
                    Row(
                      children: [
                        // Logo HpotWifi
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0C60AF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.wifi,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          loc.appTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        // Bouton fermer
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close,
                            color: colors.textSecondary,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Titre
                    Text(
                      loc.forgotPasswordTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Sous-titre / Description
                    Text(
                      loc.forgotPasswordSubtitle,
                      style: TextStyle(
                        fontSize: 15,
                        color: colors.textSecondary,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Champ Email
                    AppTextField.email(
                      controller: controller,
                      errorText: errorText,
                      hint: loc.emailLabel,
                    ),

                    const SizedBox(height: 16),

                    // Lien retour à la connexion
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        context.goNamed('login');
                      },
                      child: Text(
                        loc.backToLogin,
                        style: TextStyle(
                          fontSize: 15,
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Bouton Continue
                    AppButton(
                      label: loc.continueButton,
                      onPressed: filled
                          ? () => sendResetLink(dialogContext, setState)
                          : null,
                      enabled: filled,
                      backgroundColor:
                          filled ? colors.buttonActive : colors.buttonInactive,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  ).whenComplete(() => controller.dispose());
}
