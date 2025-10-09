import 'package:flutter/material.dart';
import 'package:hpotwifi/core/theme/app_styles.dart';
import 'package:hpotwifi/l10n/app_localizations.dart';
import '../models/hotspot.dart';

class HotspotCard extends StatelessWidget {
  final Hotspot hotspot;
  final VoidCallback? onTap;

  const HotspotCard({
    super.key,
    required this.hotspot,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    final String roleLabel = hotspot.role == HotspotRole.owner
        ? loc.owner
        : loc.assistant;
    final Color roleColor = hotspot.role == HotspotRole.owner
        ? colors.ownerBadge
        : colors.assistantBadge;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            decoration: BoxDecoration(
              color: colors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colors.cardBorder,
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: colors.statusActive,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
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
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 1,
                  color: colors.separatorLight,
                ),
                const SizedBox(height: 12),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${hotspot.price} ${loc.fcfa}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: colors.statusActive,
                                shape: BoxShape.circle,
                              ),
                            ),
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
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loc.dailySale,
                      style: TextStyle(
                        fontSize: 11,
                        color: colors.textSecondary,
                      ),
                    ),
                    Text(
                      loc.users,
                      style: TextStyle(
                        fontSize: 11,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -1.5,
            right: -1.5,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: roleColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(10.5),
                ),
              ),
              child: Text(
                roleLabel,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
