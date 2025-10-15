import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../app/providers/global_providers.dart';

Future<void> showOtpDialog(BuildContext context, String email) async {
  final controller = TextEditingController();

  const otpLength = 6;
  bool filled = false;
  bool canResend = false;
  bool verifying = false;
  int remainingSeconds = 120;
  String? errorText;

  Timer? timer;
  bool isOpen = true;
  StateSetter? _setState;

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
      final colors = AppColors.of(dialogContext);
      final loc = AppLocalizations.of(dialogContext)!;

      void startTimer() {
        timer?.cancel();
        timer = Timer.periodic(const Duration(seconds: 1), (t) {
          if (!isOpen) {
            t.cancel();
            return;
          }
          if (remainingSeconds > 0) {
            remainingSeconds--;
          } else {
            canResend = true;
            t.cancel();
          }
          _setState?.call(() {});
        });
      }

      startTimer();

      Future<void> closeDialog() async {
        if (!isOpen) return;
        isOpen = false;
        timer?.cancel();
        timer = null;

        if (dialogContext.mounted) {
          Navigator.of(dialogContext).pop();
        }

        // Petite attente avant de disposer le controller
        await Future.delayed(const Duration(milliseconds: 200));
        controller.dispose();
      }

      return Consumer(
        builder: (_, ref, ___) {
          final authController = ref.read(authControllerProvider.notifier);

          Future<void> resendCode() async {
            if (!canResend) return;
            _setState?.call(() {
              canResend = false;
              remainingSeconds = 120;
              errorText = null;
            });
            startTimer();

            await showAppLoader(dialogContext, message: loc.loading);
            final success = await authController.sendOtp(email);
            if (dialogContext.mounted) Navigator.of(dialogContext).pop();

            if (!success) {
              final state = ref.read(authControllerProvider);
              _setState?.call(() {
                errorText = state.errorMessage ?? loc.otpSendFailed;
              });
            }
          }

          Future<void> verifyCode() async {
            if (verifying || !filled) return;
            verifying = true;

            FocusScope.of(dialogContext).unfocus();
            final code = controller.text.trim();

            if (code.length != otpLength) {
              _setState?.call(() {
                errorText = loc.otpInvalid;
              });
              verifying = false;
              return;
            }

            await showAppLoader(dialogContext, message: loc.loading);
            final success = await authController.verifyOtp(email, code);
            if (dialogContext.mounted) Navigator.of(dialogContext).pop();

            verifying = false;

            if (success) {
              await closeDialog();

              // 🔒 Navigation retardée pour éviter les erreurs framework
              await Future.delayed(const Duration(milliseconds: 250));
              if (context.mounted) {
                GoRouter.of(context).goNamed(
                  'registerDetails',
                  extra: {'email': email},
                );
              }
            } else {
              final state = ref.read(authControllerProvider);
              if (isOpen) {
                _setState?.call(() {
                  errorText = state.errorMessage ?? loc.otpInvalid;
                });
              }
            }
          }

          return StatefulBuilder(
            builder: (sbContext, setState) {
              _setState ??= setState;

              void updateFilled(String value) {
                setState(() {
                  filled = value.trim().length == otpLength;
                  errorText = null;
                });
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
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.large),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.lock_outline,
                                size: 48, color: colors.buttonActive),
                            GestureDetector(
                              onTap: closeDialog,
                              child: Icon(Icons.close_rounded,
                                  color: colors.textSecondary, size: 26),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          loc.otpTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${loc.otpSubtitle} ${maskedEmail()}',
                          style: TextStyle(
                            fontSize: 15,
                            color: colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          hintText: loc.otpPlaceholder,
                          controller: controller,
                          keyboardType: TextInputType.number,
                          errorText: errorText,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(otpLength),
                          ],
                          onChanged: updateFilled,
                        ),
                        const SizedBox(height: 16),
                        AppButton(
                          label: loc.otpButton,
                          enabled: filled && !verifying,
                          onPressed: filled ? verifyCode : null,
                          backgroundColor: filled
                              ? colors.buttonActive
                              : colors.buttonInactive,
                        ),
                        const SizedBox(height: 12),
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
      );
    },
  );
}
