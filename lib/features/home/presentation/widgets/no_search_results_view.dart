// lib/features/home/presentation/widgets/no_search_results_view.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../l10n/app_localizations.dart';

class NoSearchResultsView extends StatelessWidget {
  final String searchQuery;

  const NoSearchResultsView({
    super.key,
    required this.searchQuery,
  });

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
              Icons.search_off,
              size: 100,
              color: colors.textSecondary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 24),
            Text(
              loc.noSearchResults,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              loc.noSearchResultsMessage(searchQuery),
              style: TextStyle(
                fontSize: 15,
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
