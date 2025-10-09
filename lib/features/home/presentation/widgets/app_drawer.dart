import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hpotwifi/app/providers/global_providers.dart';
import 'package:hpotwifi/core/theme/app_styles.dart';
import 'package:hpotwifi/l10n/app_localizations.dart';


class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;
    final localeNotifier = ref.read(localeProvider.notifier);

    return Drawer(
      backgroundColor: colors.surface,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: colors.textPrimary,
                      size: 28,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _DrawerItem(
                    icon: Icons.add_circle_outline,
                    label: 'Ajouter un hospot',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 8),
                  _DrawerItem(
                    icon: Icons.receipt_long_outlined,
                    label: 'Gestion des forfaits',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 8),
                  _DrawerItem(
                    icon: Icons.local_offer_outlined,
                    label: 'Mes vendeurs',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 8),
                  _DrawerItem(
                    icon: Icons.language,
                    label: 'Langue',
                    onTap: () {
                      localeNotifier.toggle();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _DrawerItem(
                icon: Icons.logout,
                label: 'Déconnexion',
                onTap: () {
                  Navigator.pop(context);
                  context.goNamed('login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: colors.textPrimary,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
