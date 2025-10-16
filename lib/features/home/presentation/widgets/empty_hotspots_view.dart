// lib/features/home/presentation/widgets/empty_hotspots_view.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../l10n/app_localizations.dart';

class EmptyHotspotsView extends StatelessWidget {
  const EmptyHotspotsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 100,
              color: colors.textSecondary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 24),
            Text(
              loc.noHotspotsTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              loc.noHotspotsMessage,
              style: TextStyle(
                fontSize: 15,
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            AppButton(
              label: loc.addFirstHotspot,
              onPressed: () => context.pushNamed('addHotspot'),
              backgroundColor: colors.buttonActive,
            ),
          ],
        ),
      ),
    );
  }
}
