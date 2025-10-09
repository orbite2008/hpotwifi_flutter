import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../l10n/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: colors.surface,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(loc.language, style: TextStyle(color: colors.textPrimary)),
              onTap: () => context.goNamed('settings'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Logout', style: TextStyle(color: colors.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                context.goNamed('login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
