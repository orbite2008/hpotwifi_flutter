// lib/features/home/presentation/pages/hotspot_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/hotspot_info_card.dart';
import '../../../../core/widgets/horizontal_tab_bar.dart';
import '../../../../core/widgets/search_filter_bar.dart';
import '../../../../core/widgets/user_list_item.dart';
import '../../../../core/widgets/custom_fab.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/filter_dialog.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/hotspot_detail_controller.dart';

/// Page de détails d'un hotspot
///
/// Reçoit l'ID du hotspot et charge les données depuis l'API
class HotspotDetailPage extends ConsumerStatefulWidget {
  final int hotspotId;

  const HotspotDetailPage({
    super.key,
    required this.hotspotId,
  });

  @override
  ConsumerState<HotspotDetailPage> createState() => _HotspotDetailPageState();
}

class _HotspotDetailPageState extends ConsumerState<HotspotDetailPage> {
  int _selectedTabIndex = 1;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  // Filtres
  bool _showConnected = true;
  bool _showDisconnected = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    final hotspotAsync = ref.watch(hotspotDetailControllerProvider(widget.hotspotId));

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AuthAppBar(
        title: hotspotAsync.when(
          data: (hotspot) => hotspot.hotspotwifiname,
          loading: () => loc.loading,
          error: (_, __) => 'Erreur',
        ),
        showReportButton: false,
        showTicketButton: false,
      ),
      body: hotspotAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: colors.primary),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 80, color: colors.error),
              const SizedBox(height: 16),
              Text(
                error.toString(),
                style: TextStyle(fontSize: 16, color: colors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(hotspotDetailControllerProvider(widget.hotspotId)),
                child: Text(loc.retry),
              ),
            ],
          ),
        ),
        data: (hotspot) => _buildContent(hotspot, colors, loc),
      ),
    );
  }

  Widget _buildContent(dynamic hotspot, AppColors colors, AppLocalizations loc) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: HotspotInfoCard(
            zone: hotspot.hotspotzonename,
            wifiName: hotspot.hotspotwifiname,
            district: hotspot.neighborhood,
            city: hotspot.city,
            onEdit: () => context.pushNamed(
              'editHotspot',
              pathParameters: {'id': widget.hotspotId.toString()}, // ✅ CORRECTION
            ),
          ),
        ),

        // Tabs primaires
        HorizontalTabBar(
          tabs: [
            TabItem(
              label: loc.graph,
              isSelected: _selectedTabIndex == 0,
              onTap: () => setState(() => _selectedTabIndex = 0),
            ),
            TabItem(
              label: loc.userList,
              isSelected: _selectedTabIndex == 1,
              onTap: () => setState(() => _selectedTabIndex = 1),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Tabs secondaires
        HorizontalTabBar(
          tabs: [
            TabItem(
              label: loc.activationHistory,
              isSelected: false,
              onTap: () {},
            ),
            TabItem(
              label: loc.ticketManagement,
              isSelected: false,
              onTap: () {},
            ),
          ],
        ),

        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SearchFilterBar(
            controller: _searchController,
            hintText: 'Rechercher',
            onFilterTap: _showFilterDialog,
          ),
        ),

        const SizedBox(height: 16),

        Expanded(
          child: _selectedTabIndex == 0
              ? _buildGraphView(loc)
              : _buildUserListView(colors, loc),
        ),
      ],
    );
  }

  Widget _buildGraphView(AppLocalizations loc) {
    return EmptyStateView(
      icon: Icons.bar_chart,
      message: loc.graphComingSoon,
    );
  }

  Widget _buildUserListView(AppColors colors, AppLocalizations loc) {
    final allUsers = [
      {'id': '12345678', 'isConnected': true, 'package': 500},
      {'id': '87654321', 'isConnected': true, 'package': 500},
      {'id': '11223344', 'isConnected': false, 'package': 500},
      {'id': '55667788', 'isConnected': true, 'package': 500},
      {'id': '99887766', 'isConnected': false, 'package': 500},
    ];

    final filteredUsers = _filterUsers(allUsers);

    if (filteredUsers.isEmpty) {
      return EmptyStateView(
        icon: Icons.person_off,
        message: loc.noUsersFound,
      );
    }

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
      final matchesSearch = _searchQuery.isEmpty ||
          user['id'].toString().toLowerCase().contains(_searchQuery);
      final isConnected = user['isConnected'] as bool;
      final matchesFilter = (isConnected && _showConnected) ||
          (!isConnected && _showDisconnected);
      return matchesSearch && matchesFilter;
    }).toList();
  }

  Future<void> _showFilterDialog() async {
    final result = await showFilterDialog(
      context: context,
      initialShowConnected: _showConnected,
      initialShowDisconnected: _showDisconnected,
    );

    if (result != null) {
      setState(() {
        _showConnected = result.showConnected;
        _showDisconnected = result.showDisconnected;
      });
    }
  }
}
