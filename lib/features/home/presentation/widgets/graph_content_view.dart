// lib/features/home/presentation/widgets/graph_content_view.dart

import 'package:flutter/material.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../l10n/app_localizations.dart';

class GraphContentView extends StatelessWidget {
  const GraphContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // ✅ Pour l'instant vide (EmptyState)
    // TODO: Implémenter le graphique plus tard
    final graphData = <String>[]; // Simuler données vides

    if (graphData.isEmpty) {
      return EmptyStateView(
        icon: Icons.bar_chart,
        message: loc.graphComingSoon,
      );
    }

    // ✅ Quand il y aura des données, afficher ici
    return Center(
      child: Text('Graphique avec données'),
    );
  }
}
