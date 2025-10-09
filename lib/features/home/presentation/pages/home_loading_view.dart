import 'package:flutter/material.dart';
import '../../../../core/theme/app_styles.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: CircularProgressIndicator(color: colors.primary),
      ),
    );
  }
}
