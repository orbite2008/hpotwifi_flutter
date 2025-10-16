import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../l10n/app_localizations.dart';
import 'forgot_password_otp_dialog.dart';

/// Dialogue : Mot de passe oublié
Future<void> showForgotPasswordDialog(BuildContext context) async {
  final emailController = TextEditingController();
  bool filled = false;
  String? errorText;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return Consumer(
        builder: (context, ref, _) {
          final colors = AppColors.of(context);
          final loc = AppLocalizations.of(context)!;

          Future<void> sendResetLink(StateSetter setState) async {
            final email = emailController.text.trim();

            // Ferme le clavier
            FocusScope.of(dialogContext).unfocus();

            final emailError =
            FormValidators.validateEmail(dialogContext, email);
            if (emailError != null) {
              setState(() => errorText = emailError);
              return;
            }

            await showAppLoader(dialogContext, message: loc.loading);
            await Future.delayed(const Duration(seconds: 2));

            if (!dialogContext.mounted) return;
            Navigator.of(dialogContext).pop(); // Ferme le loader
            Navigator.of(dialogContext).pop(); // Ferme le dialogue actuel

            await showForgotPasswordOtpDialog(context, email);
          }

          return StatefulBuilder(
            builder: (context, setState) {
              emailController.addListener(() {
                setState(() {
                  filled = emailController.text.trim().isNotEmpty;
                  errorText = null;
                });
              });

              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Dialog(
                  backgroundColor: colors.surface.withValues(alpha: 0.97),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.large),
                  ),
                  insetPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.large),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔹 En-tête : icône + bouton fermer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.lock_reset_rounded,
                              size: 50,
                              color: colors.buttonActive,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(dialogContext).pop(),
                              child: Icon(
                                Icons.close_rounded,
                                color: colors.textSecondary,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // 🔹 Titre
                        Text(
                          loc.forgotPasswordTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // 🔹 Sous-titre
                        Text(
                          loc.forgotPasswordSubtitle,
                          style: TextStyle(
                            fontSize: 15,
                            color: colors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // 🔹 Champ Email
                        AppTextField.email(
                          controller: emailController,
                          errorText: errorText,
                          hint: loc.emailLabel,
                        ),
                        const SizedBox(height: 20),

                        // 🔹 Bouton Envoyer
                        AppButton(
                          label: loc.continueBtn,
                          enabled: filled,
                          onPressed:
                          filled ? () => sendResetLink(setState) : null,
                          backgroundColor: filled
                              ? colors.buttonActive
                              : colors.buttonInactive,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    },
  ).whenComplete(() => emailController.dispose());
}
