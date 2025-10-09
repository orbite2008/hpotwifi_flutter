// lib/core/utils/form_validators.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// Classe centralisée pour toutes les validations de formulaire.
class FormValidators {
  /// Vérifie si un email est valide
  static String? validateEmail(BuildContext context, String? value) {
    final loc = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return loc.emailRequired;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return loc.signupInvalidEmail;
    }

    return null;
  }

  /// Vérifie si un mot de passe est valide (min 6 caractères)
  static String? validatePassword(BuildContext context, String? value) {
    final loc = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty) {
      return loc.passwordRequired;
    }
    if (value.length < 6) {
      return loc.passwordTooShort;
    }

    return null;
  }

  /// Vérifie si deux mots de passe correspondent
  static String? validatePasswordConfirmation(
      BuildContext context, String? password, String? confirmPassword) {
    final loc = AppLocalizations.of(context)!;

    if (confirmPassword == null || confirmPassword.isEmpty) {
      return loc.passwordConfirmRequired;
    }
    if (password != confirmPassword) {
      return loc.passwordMismatch;
    }

    return null;
  }

  /// Vérifie un numéro de téléphone (basique)
  static String? validatePhone(BuildContext context, String? value) {
    final loc = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) return loc.phoneRequired;

    final phoneRegex = RegExp(r'^[0-9+]{6,15}$');
    if (!phoneRegex.hasMatch(value)) return loc.phoneInvalid;

    return null;
  }
}
