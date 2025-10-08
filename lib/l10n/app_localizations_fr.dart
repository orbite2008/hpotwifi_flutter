// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'HpotWiFi';

  @override
  String get welcome => 'Bienvenue dans Hotspot Wifi';

  @override
  String get language => 'Langue';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get loading => 'Chargement en cours...';

  @override
  String get signupCreateAccountTitle => 'Création de compte';

  @override
  String get signupEnterEmailSubtitle => 'Entrez votre email pour une validation';

  @override
  String get continueBtn => 'Continuer';

  @override
  String get signupHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get loginLink => 'Connectez-vous';

  @override
  String get signupInvalidEmail => 'Adresse e-mail invalide. Veuillez réessayer.';

  @override
  String get countryRequired => 'Veuillez sélectionner un pays.';

  @override
  String get otpTitle => 'Vérification du code';

  @override
  String get otpSubtitle => 'Nous venons d\'envoyer un code de vérification à l\'adresse';

  @override
  String get otpPlaceholder => 'Entrez le code à 5 chiffres';

  @override
  String get otpButton => 'Vérifier';

  @override
  String get otpInvalid => 'Code invalide. Veuillez réessayer.';

  @override
  String get resendCodeBtn => 'Renvoyer le code';

  @override
  String get nameLabel => 'Nom';

  @override
  String get firstnameLabel => 'Prénom';

  @override
  String get phoneLabel => 'Numéro';

  @override
  String get cityLabel => 'Ville';

  @override
  String get countryLabel => 'Pays';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get termsDescription => 'En continuant, vous acceptez les';

  @override
  String get termsAndConditions => 'Termes et conditions';

  @override
  String get createAccountBtn => 'Créer un compte';

  @override
  String get accountCreatedMessage => 'Compte créé avec succès !';

  @override
  String get passwordConfirmLabel => 'Confirmer le mot de passe';

  @override
  String get passwordMismatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get passwordRequired => 'Le mot de passe est requis.';

  @override
  String get termsRequired => 'Vous devez accepter les termes et conditions avant de continuer.';
}
