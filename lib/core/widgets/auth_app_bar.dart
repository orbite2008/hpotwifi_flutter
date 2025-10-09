import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_styles.dart';

enum AppBarTitleAlignment { left, center, right }

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBarTitleAlignment alignment;

  const AuthAppBar({
    super.key,
    required this.title,
    this.alignment = AppBarTitleAlignment.left,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final brightness = Theme.of(context).brightness;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colors.background,
      statusBarIconBrightness:
      brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      statusBarBrightness:
      brightness == Brightness.dark ? Brightness.dark : Brightness.light,
    ));

    MainAxisAlignment alignmentMode;
    switch (alignment) {
      case AppBarTitleAlignment.left:
        alignmentMode = MainAxisAlignment.start;
        break;
      case AppBarTitleAlignment.right:
        alignmentMode = MainAxisAlignment.end;
        break;
      default:
        alignmentMode = MainAxisAlignment.center;
    }

    return AppBar(
      backgroundColor: colors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 64,
      title: Row(
        mainAxisAlignment: alignmentMode,
        children: [
          const Icon(Icons.wifi, color: Color(0xFF0C60AF)),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
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
