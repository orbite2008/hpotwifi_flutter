import 'package:flutter/material.dart';
import '../theme/app_styles.dart';

/// Bouton arrondi minimaliste sans ripple ni ombre, compatible light/dark.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final double height;
  final double radius;
  final Color? backgroundColor;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.height = 56,
    this.radius = AppRadius.medium,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final bgColor = backgroundColor ??
        (enabled ? colors.primary : colors.disabled.withValues(alpha: 0.8));

    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(bgColor),
          overlayColor:
          WidgetStateProperty.all(Colors.white.withValues(alpha: 0.05)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
        onPressed: enabled ? onPressed : null,
        child: Text(
          label,
          style: AppTextStyles.button.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
