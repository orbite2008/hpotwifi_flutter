import 'package:flutter/material.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_button.dart';

class HomeErrorView extends StatelessWidget {
  const HomeErrorView({super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: colors.error, size: 36),
          const SizedBox(height: 12),
          Text(message,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.textPrimary)),
          const SizedBox(height: 16),
          AppButton(label: 'Réessayer', onPressed: onRetry, backgroundColor: colors.buttonActive),
        ],
      ),
    );
  }
}
