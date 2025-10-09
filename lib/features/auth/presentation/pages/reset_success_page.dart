import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../l10n/app_localizations.dart';

class ResetSuccessPage extends ConsumerWidget {
  const ResetSuccessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AuthAppBar(title: loc.appTitle),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.large),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Image.asset(
                        AppAssets.resetPwd,
                        width: 130,
                        height: 130,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 32),

                      // Message de succès
                      Text(
                        loc.passwordResetSuccessTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Bouton Connexion
                      AppButton(
                        label: loc.loginBtn,
                        onPressed: () => context.goNamed('login'),
                        backgroundColor: colors.buttonActive,
                      ),

                      const Spacer()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
