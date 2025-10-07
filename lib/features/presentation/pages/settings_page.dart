// lib/features/presentation/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/providers/global_providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final localeAsync = ref.watch(localeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);
    final localeNotifier = ref.read(localeProvider.notifier);

    final themeMode = themeModeAsync.value ?? ThemeMode.system;
    final locale = localeAsync.value ?? const Locale('fr');

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text('App Settings', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Thème actuel'),
                Text(themeMode.name),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.brightness_6_outlined),
              label: const Text('Changer le thème'),
              onPressed: () => themeNotifier.toggle(),
            ),
            const Divider(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Langue actuelle'),
                Text(locale.languageCode.toUpperCase()),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.language_outlined),
              label: const Text('Changer la langue'),
              onPressed: () => localeNotifier.toggle(),
            ),
          ],
        ),
      ),
    );
  }
}
