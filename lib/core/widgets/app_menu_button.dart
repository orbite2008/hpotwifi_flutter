import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_styles.dart';

/// Enum pour identifier chaque action du menu contextuel
enum AppBarMenuAction {
  addHotspot,
  manageTickets,
  mySellers,
  report,
  profile,
}

/// Bouton de menu 3 points (utilisable sur toutes les pages)
class AppMenuButton extends StatelessWidget {
  const AppMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return PopupMenuButton<AppBarMenuAction>(
      icon: Icon(Icons.more_vert_rounded, color: colors.textPrimary),
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: colors.surface,
      onSelected: (action) => _handleAction(context, action),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: AppBarMenuAction.addHotspot,
          child: Row(
            children: [
              Icon(Icons.add_circle_outline, color: colors.textSecondary),
              const SizedBox(width: 12),
              Text(loc.addHotspot, style: TextStyle(color: colors.textPrimary)),
            ],
          ),
        ),
        PopupMenuItem(
          value: AppBarMenuAction.manageTickets,
          child: Row(
            children: [
              Icon(Icons.confirmation_number_outlined,
                  color: colors.textSecondary),
              const SizedBox(width: 12),
              Text(loc.manageTickets,
                  style: TextStyle(color: colors.textPrimary)),
            ],
          ),
        ),
        PopupMenuItem(
          value: AppBarMenuAction.mySellers,
          child: Row(
            children: [
              Icon(Icons.people_outline, color: colors.textSecondary),
              const SizedBox(width: 12),
              Text(loc.mySellers, style: TextStyle(color: colors.textPrimary)),
            ],
          ),
        ),
        PopupMenuItem(
          value: AppBarMenuAction.report,
          child: Row(
            children: [
              Icon(Icons.bar_chart_outlined, color: colors.textSecondary),
              const SizedBox(width: 12),
              Text(loc.report, style: TextStyle(color: colors.textPrimary)),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: AppBarMenuAction.profile,
          child: Row(
            children: [
              Icon(Icons.person_outline, color: colors.textSecondary),
              const SizedBox(width: 12),
              Text(loc.myProfile, style: TextStyle(color: colors.textPrimary)),
            ],
          ),
        ),
      ],
    );
  }

  /// Navigation centralisée vers les routes nommées du GoRouter
  void _handleAction(BuildContext context, AppBarMenuAction action) {
    final router = GoRouter.of(context);

    switch (action) {
      case AppBarMenuAction.addHotspot:
        router.pushNamed('addHotspot');
        break;
      case AppBarMenuAction.manageTickets:
        router.pushNamed('tickets');
        break;
      case AppBarMenuAction.mySellers:
        router.pushNamed('sellers');
        break;
      case AppBarMenuAction.report:
        router.pushNamed('report');
        break;
      case AppBarMenuAction.profile:
        router.pushNamed('profile');
        break;
    }
  }
}
