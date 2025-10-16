// lib/features/home/presentation/widgets/tickets_content_view.dart

import 'package:flutter/material.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../l10n/app_localizations.dart';

class TicketsContentView extends StatelessWidget {
  final String searchQuery;

  const TicketsContentView({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // ✅ Données mockées (remplacer par API plus tard)
    final ticketsData = <Map<String, dynamic>>[]; // Vide pour l'instant

    // ✅ Si vide, afficher EmptyState
    if (ticketsData.isEmpty) {
      return EmptyStateView(
        icon: Icons.confirmation_number,
        message: 'Gestion des tickets à venir',
      );
    }

    // ✅ Quand il y aura des données, afficher ici
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: ticketsData.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Ticket ${index + 1}'),
        );
      },
    );
  }
}
