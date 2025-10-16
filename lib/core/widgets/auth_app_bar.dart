// lib/core/widgets/auth_app_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_styles.dart';
import 'app_menu_button.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showReportButton;
  final bool showTicketButton;

  const AuthAppBar({
    super.key,
    required this.title,
    this.showReportButton = false,
    this.showTicketButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final brightness = Theme.of(context).brightness;
    final currentRoute = GoRouterState.of(context).matchedLocation;

    // Appliquer le thème système (status bar)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colors.background,
      statusBarIconBrightness:
      brightness == Brightness.dark ? Brightness.light : Brightness.dark,
    ));

    final isHomePage = currentRoute == '/' || currentRoute == '/home';

    return AppBar(
      backgroundColor: colors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: !isHomePage,
      toolbarHeight: 64,
      titleSpacing: 16,
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 👈 Logo + titre
          Row(
            children: [
              const Icon(Icons.wifi, color: Color(0xFF0C60AF), size: 26),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          if (isHomePage)
            Row(
              children: [
                if (showReportButton)
                  IconButton(
                    onPressed: () => context.pushNamed('report'),
                    icon: Icon(Icons.bar_chart_outlined,
                        color: colors.textPrimary),
                    tooltip: 'Rapport',
                  ),
                if (showTicketButton)
                  IconButton(
                    onPressed: () => context.pushNamed('tickets'),
                    icon: Icon(Icons.confirmation_number_outlined,
                        color: colors.textPrimary),
                    tooltip: 'Tickets',
                  ),
                const AppMenuButton(),
              ],
            ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: colors.border.withValues(alpha: 0.4),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
