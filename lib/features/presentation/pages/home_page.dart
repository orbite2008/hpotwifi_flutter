import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/app_button.dart';
import '../../../app/providers/global_providers.dart';
import '../../../core/theme/app_theme.dart';

/// Page de test pour les widgets principaux (champ + bouton)
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final themeModeAsync = ref.watch(themeModeProvider);
    final themeModeNotifier = ref.read(themeModeProvider.notifier);

    // palette adaptative selon le thème actif
    final colors = Theme.of(context).appColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Test Widgets'),
        backgroundColor: Colors.transparent,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        actions: [
          if (!themeModeAsync.isLoading)
            IconButton(
              icon: Icon(
                themeModeAsync.value == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: colors.textPrimary,
              ),
              tooltip: 'Changer le thème',
              onPressed: () => themeModeNotifier.toggle(),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextField.email(controller: emailController),
            const SizedBox(height: 16),
            AppTextField.password(controller: passwordController),
            const SizedBox(height: 30),
            AppButton(
              label: 'Connexion',
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            AppButton(
              label: 'Désactivé',
              onPressed: () {},
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
