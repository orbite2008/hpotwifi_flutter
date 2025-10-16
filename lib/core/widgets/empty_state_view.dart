// lib/core/widgets/empty_state_view.dart

import 'package:flutter/material.dart';
import '../theme/app_styles.dart';

class EmptyStateView extends StatelessWidget {
  final IconData icon;
  final String message;
  final double iconSize;
  final Color? iconColor;
  final TextStyle? messageStyle;

  const EmptyStateView({
    super.key,
    required this.icon,
    required this.message,
    this.iconSize = 80,
    this.iconColor,
    this.messageStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor ?? colors.disabled,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: messageStyle ??
                TextStyle(
                  fontSize: 16,
                  color: colors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
