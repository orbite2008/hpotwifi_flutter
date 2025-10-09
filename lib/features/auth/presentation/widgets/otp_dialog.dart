import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

/// Dialogue de vérification du code OTP
Future<void> showOtpDialog(BuildContext context, String email) async {
  final controller = TextEditingController();
  bool filled = false;
  bool canResend = false;
  int remainingSeconds = 120; // durée 2 minutes
  String? errorText;
  Timer? timer;

  // Masquer partiellement l’adresse e-mail
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
      // Lancement du minuteur
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

      return Consumer(
        builder: (context, ref, _) {
          // Thème et localisation réactifs
          final colors = AppColors.of(context);
          final loc = AppLocalizations.of(context)!;

          return StatefulBuilder(
            builder: (context, setState) {
              void updateFilled(String value) {
                if (value.length > 5) {
                  controller.text = value.substring(0, 5);
                  controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: controller.text.length),
                  );
                }
                setState(() {
                  filled = controller.text.trim().length == 5;
                  errorText = null;
                });
              }

              void dismissKeyboard() => FocusScope.of(context).unfocus();

              void resendCode() {
                if (!canResend) return;
                setState(() {
                  canResend = false;
                  remainingSeconds = 120;
                  errorText = null;
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

                await showAppLoader(context, message: loc.loading);
                await Future.delayed(const Duration(seconds: 2));

                if (!context.mounted) return;
                Navigator.of(context).pop(); // Ferme le loader

                final code = controller.text.trim();
                if (code == "00000") {
                  await Future.delayed(const Duration(milliseconds: 500));
                  if (dialogContext.mounted) {
                    Navigator.of(dialogContext).pop(); // Ferme le dialogue
                    context.goNamed('registerDetails');
                  }
                } else {
                  setState(() => errorText = loc.otpInvalid);
                }
              }

              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Dialog(
                  backgroundColor: colors.surface.withValues(alpha: 0.97),
                  insetPadding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.large),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final maxWidth =
                      constraints.maxWidth > 400 ? 400.0 : constraints.maxWidth;

                      return ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.large),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Ligne icône + bouton fermer
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.lock_outline,
                                    size: 48,
                                    color: colors.buttonActive,
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        Navigator.of(dialogContext).pop(),
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: colors.textSecondary,
                                      size: 26,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Titre principal
                              Text(
                                loc.otpTitle,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: colors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Sous-titre
                              Text(
                                '${loc.otpSubtitle} ${maskedEmail()}',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: colors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Champ OTP
                              AppTextField(
                                hintText: loc.otpPlaceholder,
                                controller: controller,
                                keyboardType: TextInputType.number,
                                errorText: errorText,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: updateFilled,
                              ),

                              const SizedBox(height: 16),

                              // Bouton Vérifier
                              AppButton(
                                label: loc.otpButton,
                                enabled: filled,
                                onPressed: filled ? verifyCode : null,
                                backgroundColor: filled
                                    ? colors.buttonActive
                                    : colors.buttonInactive,
                              ),

                              const SizedBox(height: 12),

                              // Bouton Renvoyer le code + timer
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
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      );
    },
  ).whenComplete(() => timer?.cancel());
}
