// lib/features/home/presentation/widgets/users_list_content_view.dart

import 'package:flutter/material.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/user_list_item.dart';
import '../../../../l10n/app_localizations.dart';

class UsersListContentView extends StatelessWidget {
  final String searchQuery;
  final bool showConnected;
  final bool showDisconnected;

  const UsersListContentView({
    super.key,
    required this.searchQuery,
    required this.showConnected,
    required this.showDisconnected,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    // ✅ Données mockées (remplacer par API plus tard)
    final allUsers = [
      {'id': '12345678', 'isConnected': true, 'package': 500},
      {'id': '87654321', 'isConnected': true, 'package': 500},
      {'id': '11223344', 'isConnected': false, 'package': 500},
      {'id': '55667788', 'isConnected': true, 'package': 500},
      {'id': '99887766', 'isConnected': false, 'package': 500},
    ];

    final filteredUsers = _filterUsers(allUsers);

    // ✅ Si vide, afficher EmptyState
    if (filteredUsers.isEmpty) {
      return EmptyStateView(
        icon: Icons.person_off,
        message: loc.noUsersFound,
      );
    }

    // ✅ Affichage du contenu
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        final isConnected = user['isConnected'] as bool;

        return UserListItem(
          userId: user['id'].toString(),
          status: isConnected ? loc.connected : loc.disconnected,
          packageInfo: 'Forfait de ${user['package']}f',
          isConnected: isConnected,
        );
      },
    );
  }

  List<Map<String, dynamic>> _filterUsers(List<Map<String, dynamic>> users) {
    return users.where((user) {
      final matchesSearch = searchQuery.isEmpty ||
          user['id'].toString().toLowerCase().contains(searchQuery);
      final isConnected = user['isConnected'] as bool;
      final matchesFilter = (isConnected && showConnected) ||
          (!isConnected && showDisconnected);
      return matchesSearch && matchesFilter;
    }).toList();
  }
}
