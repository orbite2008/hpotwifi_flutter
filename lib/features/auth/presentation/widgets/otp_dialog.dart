import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

Future<void> showOtpDialog(BuildContext context, String email) async {
  final colors = AppColors.of(context);
  final loc = AppLocalizations.of(context)!;
  final controller = TextEditingController();

  bool filled = false;
  bool canResend = false;
  int remainingSeconds = 120; // 2 minutes
  String feedbackText = "";
  Color? feedbackColor;

  Timer? timer;

  String maskedEmail() {
    final parts = email.split('@');
    if (parts.length < 2) return email;
    final prefix = parts[0];
    final masked = prefix.length <= 3
        ? '${prefix[0]}***'
        : '${prefix.substring(0, 3)}*****';
    return '$masked@${parts[1]}';
  }

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      // Démarrage du timer sécurisé
      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          canResend = true;
          t.cancel();
        }
        if (dialogContext.mounted) {
          (dialogContext as Element).markNeedsBuild();
        }
      });

      return StatefulBuilder(
        builder: (context, setState) {
          void updateFilled(String value) {
            if (value.length > 5) {
              controller.text = value.substring(0, 5);
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
            }
            setState(() => filled = controller.text.trim().length == 5);
          }

          void dismissKeyboard() => FocusScope.of(context).unfocus();

          void resendCode() {
            if (!canResend) return;
            setState(() {
              canResend = false;
              remainingSeconds = 120;
              feedbackText = "";
            });
            timer?.cancel();
            timer = Timer.periodic(const Duration(seconds: 1), (t) {
              if (remainingSeconds > 0) {
                remainingSeconds--;
              } else {
                canResend = true;
                t.cancel();
              }
              if (context.mounted) {
                (context as Element).markNeedsBuild();
              }
            });
          }

          Future<void> verifyCode() async {
            dismissKeyboard();
            if (!filled) return;

            // Loader affiché au-dessus du blur
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );

            await Future.delayed(const Duration(seconds: 2));

            if (!context.mounted) return;
            Navigator.of(context).pop(); // ferme le loader

            // Validation du code
            final code = controller.text.trim();
            if (code == "00000") {
              setState(() {
                feedbackText = "Code vérifié avec succès.";
                feedbackColor = Colors.green;
              });

              await Future.delayed(const Duration(milliseconds: 800));
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop(); // ferme le dialogue
                context.goNamed('registerDetails'); // vers l’étape suivante
              }
            } else {
              setState(() {
                feedbackText = loc.otpInvalid;
                feedbackColor = Colors.red;
              });
            }
          }

          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              backgroundColor: colors.surface.withValues(alpha: 0.97),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.large),
              ),
              insetPadding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.large),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start, // 👉 align start
                  children: [
                    const Icon(Icons.lock_outline,
                        size: 50, color: Color(0xFF0C60AF)),
                    const SizedBox(height: 16),
                    Text(
                      loc.otpTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${loc.otpSubtitle} ${maskedEmail()}',
                      style: TextStyle(
                        fontSize: 15,
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Champ OTP
                    AppTextField(
                      hintText: loc.otpPlaceholder,
                      controller: controller,
                      keyboardType: TextInputType.number,
                      onChanged: updateFilled,
                    ),
                    const SizedBox(height: 8),

                    // Message de feedback (succès / erreur)
                    if (feedbackText.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          feedbackText,
                          style: TextStyle(
                            fontSize: 14,
                            color: feedbackColor ?? colors.textSecondary,
                          ),
                        ),
                      ),

                    const SizedBox(height: 12),

                    // Bouton vérifier
                    AppButton(
                      label: loc.otpButton,
                      enabled: filled,
                      onPressed: filled ? verifyCode : null,
                      backgroundColor: filled
                          ? colors.buttonActive
                          : colors.buttonInactive,
                    ),

                    const SizedBox(height: 12),

                    // Bouton renvoyer le code + timer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: canResend ? resendCode : null,
                          style: TextButton.styleFrom(
                            foregroundColor: canResend
                                ? colors.buttonActive
                                : colors.textSecondary,
                          ),
                          child: Text(loc.resendCodeBtn),
                        ),
                        if (!canResend) ...[
                          const SizedBox(width: 4),
                          Text(
                            '(${remainingSeconds ~/ 60}:${(remainingSeconds % 60).toString().padLeft(2, '0')})',
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  ).whenComplete(() {
    timer?.cancel();
  });
}
