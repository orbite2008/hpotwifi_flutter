// lib/features/hotspot_detail/presentation/pages/hotspot_detail_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/hotspot_info_card.dart';
import '../../../../core/widgets/custom_tab_button.dart';
import '../../../../core/widgets/search_filter_bar.dart';
import '../../../../core/widgets/user_list_item.dart';
import '../../../../core/widgets/custom_fab.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/domain/entities/hotspot_entity.dart';

class HotspotDetailPage extends StatefulWidget {
  final HotspotEntity? hotspot;

  const HotspotDetailPage({super.key, this.hotspot});

  @override
  State<HotspotDetailPage> createState() => _HotspotDetailPageState();
}

class _HotspotDetailPageState extends State<HotspotDetailPage> {
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
    final hotspot = widget.hotspot;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          hotspot?.name ?? 'Wifi Zone 1',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: HotspotInfoCard(
              zone: 'Houèkègbo',
              wifiName: hotspot?.name ?? 'Wifi zone 1',
              district: 'Agla',
              city: 'Cotonou',
              onEdit: () => context.pushNamed('editHotspot'),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  CustomTabButton(
                    label: loc.graph,
                    isSelected: _selectedTabIndex == 0,
                    onTap: () => setState(() => _selectedTabIndex = 0),
                  ),
                  const SizedBox(width: 8),
                  CustomTabButton(
                    label: loc.userList,
                    isSelected: _selectedTabIndex == 1,
                    onTap: () => setState(() => _selectedTabIndex = 1),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  CustomTabButton(
                    label: loc.activationHistory,
                    isSelected: false,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  CustomTabButton(
                    label: loc.ticketManagement,
                    isSelected: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchFilterBar(
              controller: _searchController,
              hintText: 'Rechercher',
              onFilterTap: () => _showFilterDialog(context, colors, loc),
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: _selectedTabIndex == 0
                ? _buildGraphView(colors)
                : _buildUserListView(colors, loc),
          ),
        ],
      ),
      floatingActionButton: _selectedTabIndex == 1
          ? CustomFab(onPressed: () {})
          : null,
    );
  }

  Widget _buildGraphView(AppColors colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bar_chart, size: 80, color: colors.disabled),
          const SizedBox(height: 16),
          Text(
            'Graphique à venir',
            style: TextStyle(fontSize: 16, color: colors.textSecondary),
          ),
        ],
      ),
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

    // Filtrage
    final filteredUsers = allUsers.where((user) {
      final matchesSearch = _searchQuery.isEmpty || 
                           user['id'].toString().toLowerCase().contains(_searchQuery);
      final isConnected = user['isConnected'] as bool;
      final matchesFilter = (isConnected && _showConnected) || 
                           (!isConnected && _showDisconnected);
      return matchesSearch && matchesFilter;
    }).toList();

    if (filteredUsers.isEmpty) {
      return Center(
        child: Text(
          'Aucun utilisateur trouvé',
          style: TextStyle(fontSize: 16, color: colors.textSecondary),
        ),
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

  // ✅ Dialog au lieu de BottomSheet (plus stable)
  void _showFilterDialog(BuildContext context, AppColors colors, AppLocalizations loc) {
    bool tempConnected = _showConnected;
    bool tempDisconnected = _showDisconnected;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: colors.surface,
              title: Text(
                'Filtres',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Checkbox Connecté
                  Row(
                    children: [
                      Checkbox(
                        value: tempConnected,
                        activeColor: colors.primary,
                        onChanged: (value) {
                          setDialogState(() {
                            tempConnected = value ?? true;
                          });
                        },
                      ),
                      Text(
                        loc.connected,
                        style: TextStyle(color: colors.textPrimary),
                      ),
                    ],
                  ),
                  
                  // Checkbox Déconnecté
                  Row(
                    children: [
                      Checkbox(
                        value: tempDisconnected,
                        activeColor: colors.primary,
                        onChanged: (value) {
                          setDialogState(() {
                            tempDisconnected = value ?? true;
                          });
                        },
                      ),
                      Text(
                        loc.disconnected,
                        style: TextStyle(color: colors.textPrimary),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Annuler', style: TextStyle(color: colors.textSecondary)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showConnected = tempConnected;
                      _showDisconnected = tempDisconnected;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                  ),
                  child: const Text('Appliquer', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
