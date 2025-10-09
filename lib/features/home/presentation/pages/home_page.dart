import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hpotwifi/core/theme/app_styles.dart';
import 'package:hpotwifi/features/home/presentation/models/hotspot.dart';
import 'package:hpotwifi/l10n/app_localizations.dart';


import '../widgets/hotspot_card.dart';
import '../widgets/app_drawer.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    // Données fictives (à remplacer par des vraies données depuis un provider)
    final hotspots = [
      const Hotspot(
        id: '1',
        name: 'Houékégbo',
        wifiZone: 'Wifi Zone 1',
        price: 50000,
        isDailySale: true,
        usersOnline: 10,
        role: HotspotRole.owner,
        isActive: true,
      ),
      const Hotspot(
        id: '2',
        name: 'Agla-Carrefour',
        wifiZone: 'Wifi Zone 2',
        price: 10000,
        isDailySale: true,
        usersOnline: 6,
        role: HotspotRole.assistant,
        isActive: true,
      ),
      const Hotspot(
        id: '3',
        name: 'Godomey',
        wifiZone: 'Wifi Zone 3',
        price: 50000,
        isDailySale: false,
        usersOnline: 10,
        role: HotspotRole.owner,
        isActive: true,
      ),
    ];

    return Scaffold(
      backgroundColor: colors.background,
      drawer: const AppDrawer(), // ✅ AJOUTER CETTE LIGNE
     appBar: AppBar(
  backgroundColor: colors.surface,
  elevation: 0,
  title: Row(
    children: [
      Icon(
        Icons.wifi,
        color: colors.primary,
        size: 28,
      ),
      const SizedBox(width: 8),
      Text(
        loc.appTitle,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: colors.textPrimary,
        ),
      ),
    ],
  ),
  // ✅ SUPPRIMER actions complètement
  // L'icône hamburger apparaîtra automatiquement à gauche
),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section supérieure (salutation + recherche)
          Container(
            color: colors.surface,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Salutation
                Text(
                  loc.greeting('Tynisha'),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),

                const SizedBox(height: 16),

                // Barre de recherche
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    border: Border.all(
                      color: colors.border.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: colors.hint,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: loc.searchHotspots,
                            hintStyle: TextStyle(
                              color: colors.hint,
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Titre section avec badge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  loc.myHotspots,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colors.textSecondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '08/10',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Liste des hotspots
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              itemCount: hotspots.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final hotspot = hotspots[index];
                return HotspotCard(
                  hotspot: hotspot,
                  onTap: () {
                    // TODO: Navigation vers détails du hotspot
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Ouvrir ${hotspot.name}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
