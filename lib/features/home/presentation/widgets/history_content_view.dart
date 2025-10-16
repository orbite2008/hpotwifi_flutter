// lib/features/home/presentation/widgets/history_content_view.dart

import 'package:flutter/material.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../l10n/app_localizations.dart';

class HistoryContentView extends StatelessWidget {
  final String searchQuery;

  const HistoryContentView({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // ✅ Données mockées (remplacer par API plus tard)
    final historyData = <Map<String, dynamic>>[]; // Vide pour l'instant

    // ✅ Si vide, afficher EmptyState
    if (historyData.isEmpty) {
      return EmptyStateView(
        icon: Icons.history,
        message: 'Historique d\'activation à venir',
      );
    }

    // ✅ Quand il y aura des données, afficher ici
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: historyData.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Historique ${index + 1}'),
        );
      },
    );
  }
}
