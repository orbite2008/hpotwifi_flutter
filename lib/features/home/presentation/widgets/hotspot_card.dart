import 'package:flutter/material.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/hotspot_entity.dart';
import '../models/ui_hotspot.dart';
import 'hotspot_status_dot.dart';

class HotspotCard extends StatelessWidget {
  const HotspotCard({super.key, required this.hotspot, this.onTap});
  final HotspotEntity hotspot;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    final String roleLabel =
    hotspot.role == HotspotRole.owner ? loc.owner : loc.assistant;
    final Color roleColor = hotspot.roleBadgeColor(context);
    final Color status = hotspot.statusColor(context);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.border, width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ligne statut + titre
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: HotspotStatusDot(color: status, size: 14),
                    ),
                    Text(
                      hotspot.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(height: 1, color: colors.border.withValues(alpha: 0.5)),
                const SizedBox(height: 12),

                // Zone
                Center(
                  child: Text(
                    hotspot.wifiZone,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Montant / utilisateurs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${hotspot.dailySaleAmount} ${loc.fcfa}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        HotspotStatusDot(color: status, size: 8),
                        const SizedBox(width: 6),
                        Text(
                          '${hotspot.usersOnline} ${loc.online}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(loc.dailySale,
                        style: TextStyle(fontSize: 11, color: colors.textSecondary, fontWeight: FontWeight.w500)),
                    Text(loc.users,
                        style: TextStyle(fontSize: 11, color: colors.textSecondary, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),

          // Badge de rôle
          Positioned(
            bottom: -1.5,
            right: -1.5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(10.5),
                ),
              ).copyWith(color: roleColor),
              child: Text(
                roleLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
