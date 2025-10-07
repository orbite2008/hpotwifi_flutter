// lib/core/localization/l10n.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// Classe de configuration pour la localisation (FR / EN)
class L10n {
  static const supportedLocales = [
    Locale('en'),
    Locale('fr'),
  ];

  static const localizationsDelegates = AppLocalizations.localizationsDelegates;

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;
}
