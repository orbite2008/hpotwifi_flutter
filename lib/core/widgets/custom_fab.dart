// lib/core/widgets/custom_fab.dart

import 'package:flutter/material.dart';
import '../theme/app_styles.dart';

class CustomFab extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CustomFab({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: colors.primary,
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}
