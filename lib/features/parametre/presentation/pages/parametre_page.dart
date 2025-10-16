import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/providers/global_providers.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../l10n/app_localizations.dart';

class ParametrePage extends ConsumerWidget {
  const ParametrePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    final themeModeAsync = ref.watch(themeModeProvider);
    final localeAsync = ref.watch(localeProvider);

    final themeMode = themeModeAsync.value ?? ThemeMode.system;
    final locale = localeAsync.value ?? const Locale('fr');

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          loc.settingsTitle,
          style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: colors.primary,
                    child: Text('M', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20)),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mehrima Jannat', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: colors.textPrimary)),
                      const SizedBox(height: 2),
                      Text('mehrimajannat30@gmail.com', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _SettingsTile(label: loc.editProfile, onTap: () {}, colors: colors),
              _SettingsTile(label: loc.changePassword, onTap: () {}, colors: colors),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), child: Text(loc.darkMode, style: TextStyle(color: colors.textPrimary, fontSize: 15))),
                    ),
                    Switch(
                      activeColor: colors.primary,
                      value: themeMode == ThemeMode.dark,
                      onChanged: (_) => ref.read(themeModeProvider.notifier).toggle(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                color: colors.surface,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), child: Text(loc.language, style: TextStyle(color: colors.textPrimary, fontSize: 15))),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<Locale>(
                        value: locale,
                        borderRadius: BorderRadius.circular(16),
                        items: [
                          DropdownMenuItem(value: const Locale('fr'), child: Text(loc.french, style: TextStyle(color: colors.textPrimary))),
                          DropdownMenuItem(value: const Locale('en'), child: Text(loc.english, style: TextStyle(color: colors.textPrimary))),
                        ],
                        onChanged: (lang) {
                          if (lang != null && lang != locale) {
                            ref.read(localeProvider.notifier).setLocale(lang);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
              _SettingsTile(label: loc.privacySettings, onTap: () {}, colors: colors),
              _SettingsTile(label: loc.about, onTap: () {}, colors: colors),
              const SizedBox(height: 16),
              AppButton(label: loc.logout, backgroundColor: colors.surface,  onPressed: () {}),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final AppColors colors;

  const _SettingsTile({required this.label, required this.onTap, required this.colors, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.surface,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(child: Text(label, style: TextStyle(color: colors.textPrimary, fontSize: 15))),
              Icon(Icons.chevron_right, color: colors.textSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
