// lib/core/widgets/filter_dialog.dart

import 'package:flutter/material.dart';
import '../theme/app_styles.dart';
import '../../../l10n/app_localizations.dart';

/// Résultat du dialog de filtrage
class FilterResult {
  final bool showConnected;
  final bool showDisconnected;

  const FilterResult({
    required this.showConnected,
    required this.showDisconnected,
  });
}

/// Widget réutilisable pour afficher un dialog de filtrage (Connecté/Déconnecté)
///
/// Usage:
/// ```
/// final result = await showFilterDialog(
///   context: context,
///   initialShowConnected: _showConnected,
///   initialShowDisconnected: _showDisconnected,
/// );
///
/// if (result != null) {
///   setState(() {
///     _showConnected = result.showConnected;
///     _showDisconnected = result.showDisconnected;
///   });
/// }
/// ```
Future<FilterResult?> showFilterDialog({
  required BuildContext context,
  required bool initialShowConnected,
  required bool initialShowDisconnected,
}) {
  return showDialog<FilterResult>(
    context: context,
    builder: (context) => FilterDialog(
      initialShowConnected: initialShowConnected,
      initialShowDisconnected: initialShowDisconnected,
    ),
  );
}

class FilterDialog extends StatefulWidget {
  final bool initialShowConnected;
  final bool initialShowDisconnected;

  const FilterDialog({
    super.key,
    required this.initialShowConnected,
    required this.initialShowDisconnected,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late bool _showConnected;
  late bool _showDisconnected;

  @override
  void initState() {
    super.initState();
    _showConnected = widget.initialShowConnected;
    _showDisconnected = widget.initialShowDisconnected;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(
        loc.filters,
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
          _buildCheckboxRow(
            value: _showConnected,
            label: loc.connected,
            onChanged: (value) {
              setState(() {
                _showConnected = value ?? true;
              });
            },
            colors: colors,
          ),

          // Checkbox Déconnecté
          _buildCheckboxRow(
            value: _showDisconnected,
            label: loc.disconnected,
            onChanged: (value) {
              setState(() {
                _showDisconnected = value ?? true;
              });
            },
            colors: colors,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            loc.cancel,
            style: TextStyle(color: colors.textSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(
              context,
              FilterResult(
                showConnected: _showConnected,
                showDisconnected: _showDisconnected,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(loc.apply),
        ),
      ],
    );
  }

  Widget _buildCheckboxRow({
    required bool value,
    required String label,
    required ValueChanged<bool?> onChanged,
    required AppColors colors,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Checkbox(
            value: value,
            activeColor: colors.primary,
            onChanged: onChanged,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
