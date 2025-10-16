// lib/features/home/presentation/pages/hotspot_detail_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/hotspot_info_card.dart';
import '../../../../core/widgets/horizontal_tab_bar.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/widgets/filter_dialog.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/hotspot_detail_controller.dart';
import '../widgets/graph_content_view.dart';
import '../widgets/users_list_content_view.dart';
import '../widgets/history_content_view.dart';
import '../widgets/tickets_content_view.dart';

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
  int _selectedPageIndex = 1; // 0=Graph, 1=Users, 2=History, 3=Tickets

  final _searchController = TextEditingController();
  String _searchQuery = '';

  // Filtres (seulement pour liste utilisateurs)
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
        // InfoCard
        Padding(
          padding: const EdgeInsets.all(12),
          child: HotspotInfoCard(
            zone: hotspot.hotspotzonename,
            wifiName: hotspot.hotspotwifiname,
            district: hotspot.neighborhood,
            city: hotspot.city,
            onEdit: () => context.pushNamed(
              'editHotspot',
              pathParameters: {'id': widget.hotspotId.toString()},
            ),
          ),
        ),

        // ✅ Tabs sur 2 lignes
        _buildTabsSection(loc),

        const SizedBox(height: 12),

        if (_selectedPageIndex != 0) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _searchController,
                    hintText: _getSearchHint(loc),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                if (_selectedPageIndex == 1) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: colors.primary),
                    onPressed: _showFilterDialog,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],

        Expanded(
          child: _buildPageContent(),
        ),
      ],
    );
  }

  /// ✅ Tabs sur 2 lignes (2 par ligne)
  Widget _buildTabsSection(AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          // ✅ Ligne 1: Graphique + Liste utilisateurs
          HorizontalTabBar(
            padding: EdgeInsets.zero,
            spacing: 6,
            tabs: [
              TabItem(
                label: loc.graph,
                isSelected: _selectedPageIndex == 0,
                onTap: () => setState(() => _selectedPageIndex = 0),
              ),
              TabItem(
                label: loc.userList,
                isSelected: _selectedPageIndex == 1,
                onTap: () => setState(() => _selectedPageIndex = 1),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // ✅ Ligne 2: Historique + Tickets
          HorizontalTabBar(
            padding: EdgeInsets.zero,
            spacing: 6,
            tabs: [
              TabItem(
                label: loc.activationHistory,
                isSelected: _selectedPageIndex == 2,
                onTap: () => setState(() => _selectedPageIndex = 2),
              ),
              TabItem(
                label: loc.ticketManagement,
                isSelected: _selectedPageIndex == 3,
                onTap: () => setState(() => _selectedPageIndex = 3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getSearchHint(AppLocalizations loc) {
    switch (_selectedPageIndex) {
      case 1: return 'Rechercher un utilisateur';
      case 2: return 'Rechercher dans l\'historique';
      case 3: return 'Rechercher un ticket';
      default: return 'Rechercher';
    }
  }

  Widget _buildPageContent() {
    switch (_selectedPageIndex) {
      case 0:
        return const GraphContentView();
      case 1:
        return UsersListContentView(
          searchQuery: _searchQuery,
          showConnected: _showConnected,
          showDisconnected: _showDisconnected,
        );
      case 2:
        return HistoryContentView(searchQuery: _searchQuery);
      case 3:
        return TicketsContentView(searchQuery: _searchQuery);
      default:
        return const SizedBox.shrink();
    }
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
