// lib/features/home/presentation/widgets/hotspot_success_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../l10n/app_localizations.dart';

class HotspotSuccessDialog extends StatelessWidget {
  final String wifiName;
  final String zoneName;
  final String city;
  final String neighborhood;
  final String routerName;
  final String routerPortName;
  final String serverName;

  const HotspotSuccessDialog({
    super.key,
    required this.wifiName,
    required this.zoneName,
    required this.city,
    required this.neighborhood,
    required this.routerName,
    required this.routerPortName,
    required this.serverName,
  });

  String get _copyableContent => '''
Hotspot créé avec succès !

Nom WiFi: $wifiName
Zone: $zoneName
Ville: $city
Quartier: $neighborhood
Routeur: $routerName
Port routeur: $routerPortName
Serveur: $serverName
''';

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _copyableContent));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copié !'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icône de succès
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),

            // Titre
            Text(
              loc.hotspotCreatedTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Message
            Text(
              loc.hotspotCreatedMessage(wifiName),
              style: TextStyle(
                fontSize: 14,
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Informations avec thème différent
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(loc.zoneLabel, zoneName, colors),
                  const SizedBox(height: 12),
                  _buildInfoRow(loc.cityLabel, city, colors),
                  const SizedBox(height: 12),
                  _buildInfoRow('Quartier', neighborhood, colors),
                  const SizedBox(height: 12),
                  _buildInfoRow('Routeur', routerName, colors),
                  const SizedBox(height: 12),
                  _buildInfoRow('Port routeur', routerPortName, colors),
                  const SizedBox(height: 12),
                  _buildInfoRow('Serveur', serverName, colors),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Boutons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _copyToClipboard(context),
                    icon: const Icon(Icons.copy, size: 18),
                    label: Text(loc.copy),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.primary,
                      side: BorderSide(color: colors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(loc.ok),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, AppColors colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            '$label:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: colors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
