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
  String get signupCreateAccountTitle => 'Creation de compte';

  @override
  String get signupEnterEmailSubtitle => 'Entrez votre email pour une validation';

  @override
  String get continueBtn => 'Continuer';

  @override
  String get signupHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get loginLink => 'Connectez-vous';

  @override
  String get signupSendingCode => 'Envoi du code de vérification...';

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
}
