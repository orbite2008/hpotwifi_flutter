// lib/core/widgets/hotspot_info_card.dart

import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_styles.dart';

class HotspotInfoCard extends StatelessWidget {
  final String zone;
  final String wifiName;
  final String district;
  final String city;
  final VoidCallback onEdit;

  const HotspotInfoCard({
    super.key,
    required this.zone,
    required this.wifiName,
    required this.district,
    required this.city,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(loc.zone, zone, colors),
                const SizedBox(height: 4),
                _buildInfoRow(loc.wifiName, wifiName, colors),
                const SizedBox(height: 4),
                _buildInfoRow(loc.district, district, colors),
                const SizedBox(height: 4),
                _buildInfoRow(loc.city, city, colors),
              ],
            ),
          ),

          const SizedBox(width: 10),

          InkWell(
            onTap: onEdit,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color:
                    isDark
                        ? colors.primary.withValues(alpha: 0.3)
                        : colors.primary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.edit,
                color: isDark ? colors.primary : Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, AppColors colors) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          '$label ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14, color: colors.textSecondary),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
