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

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow(loc.zone, zone, colors),
          const SizedBox(height: 12),
          _buildInfoRow(loc.wifiName, wifiName, colors),
          const SizedBox(height: 12),
          _buildInfoRow(loc.district, district, colors),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildInfoRow(loc.city, city, colors),
              ),
              // Bouton Edit
              InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, AppColors colors) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
