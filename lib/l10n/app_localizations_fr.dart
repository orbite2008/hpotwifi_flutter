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
  String get darkMode => 'Mode Sombre';

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
  String get otpSendFailed => 'Impossible d\'envoyer le code de vérification. Veuillez réessayer.';

  @override
  String get otpSendSuccess => 'Code de vérification envoyé avec succès.';

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
  String get passwordConfirmLabel => 'Confirmer le mot de passe';

  @override
  String get passwordRequired => 'Le mot de passe est requis.';

  @override
  String get passwordMismatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get termsDescription => 'En continuant, vous acceptez les';

  @override
  String get termsAndConditions => 'conditions générales d\'utilisation';

  @override
  String get termsRequired => 'Vous devez accepter les conditions.';

  @override
  String get createAccountBtn => 'Créer un compte';

  @override
  String get accountCreatedMessage => 'Compte créé avec succès !';

  @override
  String get loginTitle => 'Connectez-vous';

  @override
  String get loginSubtitle => 'Entrez vos identifiants pour vous connecter';

  @override
  String get emailLabel => 'Email';

  @override
  String get loginBtn => 'Connexion';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get noAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get signupLink => 'Créer un compte';

  @override
  String get invalidCredentials => 'Email ou mot de passe incorrect.';

  @override
  String get emailRequired => 'L\'email est requis.';

  @override
  String get loginSuccess => 'Connexion réussie !';

  @override
  String get loginFailed => 'Échec de connexion. Veuillez vérifier vos informations.';

  @override
  String get forgotPasswordTitle => 'Mot de passe oublié ?';

  @override
  String get forgotPasswordSubtitle => 'Entrez votre adresse e-mail pour recevoir un lien de réinitialisation.';

  @override
  String get resetLinkSent => 'Lien de réinitialisation envoyé !';

  @override
  String get checkYourEmail => 'Veuillez vérifier votre boîte mail pour continuer.';

  @override
  String get resetPasswordTitle => 'Créer un nouveau mot de passe';

  @override
  String get resetPasswordSubtitle => 'Veuillez entrer votre nouveau mot de passe';

  @override
  String get resetPasswordButton => 'Changer le mot de passe';

  @override
  String get passwordResetSuccessTitle => 'Votre mot de passe a été mis à jour avec succès.';

  @override
  String get passwordTooShort => 'Le mot de passe doit contenir au moins 6 caractères.';

  @override
  String get passwordConfirmRequired => 'Veuillez confirmer votre mot de passe.';

  @override
  String get phoneRequired => 'Le numéro de téléphone est requis.';

  @override
  String get phoneInvalid => 'Numéro de téléphone invalide.';

  @override
  String greeting(Object name) {
    return 'Salut, $name !';
  }

  @override
  String get searchHotspots => 'Rechercher un hotspot';

  @override
  String get myHotspots => 'Mes hotspots';

  @override
  String wifiZone(Object number) {
    return 'Wifi Zone $number';
  }

  @override
  String get noHotspotsTitle => 'Aucun hotspot';

  @override
  String get noHotspotsMessage => 'Vous n\'avez pas encore de hotspot. Commencez par en créer un !';

  @override
  String get addFirstHotspot => 'Ajouter mon premier hotspot';

  @override
  String get vendor => 'Vendeur';

  @override
  String get pullToRefresh => 'Tirer pour rafraîchir';

  @override
  String get dailySale => 'Vente du jour';

  @override
  String get online => 'online';

  @override
  String get users => 'utilisateurs';

  @override
  String get owner => 'Propriétaire';

  @override
  String get assistant => 'Assistant';

  @override
  String get fcfa => 'f';

  @override
  String get noSearchResults => 'Aucun résultat trouvé';

  @override
  String noSearchResultsMessage(Object query) {
    return 'Aucun hotspot ne correspond à \"$query\".\nEssayez un autre terme de recherche.';
  }

  @override
  String get addHotspot => 'Ajouter un hotspot';

  @override
  String get packageManagement => 'Gestion des forfaits';

  @override
  String get mySellers => 'Mes vendeurs';

  @override
  String get manageTickets => 'Gestion des tickets';

  @override
  String get report => 'Rapport';

  @override
  String get myProfile => 'Mon profil';

  @override
  String get hotspotCreatedTitle => 'Hotspot créé !';

  @override
  String hotspotCreatedMessage(Object name) {
    return 'Le hotspot \"$name\" a été créé avec succès.';
  }

  @override
  String get copy => 'Copier';

  @override
  String get ok => 'OK';

  @override
  String get addHotspotTitle => 'Ajouter un hotspot';

  @override
  String get wifiNameLabel => 'Nom du wifi';

  @override
  String get wifiNameHint => 'Entrez le nom du wifi';

  @override
  String get cityHint => 'Ville';

  @override
  String get zoneLabel => 'Zone';

  @override
  String get zoneHint => 'Zone';

  @override
  String get addButton => 'Ajouter';

  @override
  String get fieldRequired => 'Ce champ est requis';

  @override
  String get filters => 'Filtres';

  @override
  String get apply => 'Appliquer';

  @override
  String get cancel => 'Annuler';

  @override
  String get graphComingSoon => 'Graphique à venir';

  @override
  String get noUsersFound => 'Aucun utilisateur trouvé';

  @override
  String get retry => 'Réessayer';

  @override
  String get editHotspotTitle => 'Modifier un hotspot';

  @override
  String get serverNameLabel => 'Nom du serveur:';

  @override
  String get routerNameLabel => 'Nom du routeur:';

  @override
  String get bridgeNameLabel => 'Nom du bridge:';

  @override
  String get editButton => 'Modifier';

  @override
  String get editableFieldsLabel => 'Champs modifiables';

  @override
  String get hotspotActiveLabel => 'Hotspot actif';

  @override
  String get saveChangesButton => 'Enregistrer les modifications';

  @override
  String get backButton => 'Retour';

  @override
  String get districtLabel => 'Quartier';

  @override
  String get error => 'Erreur';

  @override
  String get graph => 'Graphe';

  @override
  String get userList => 'Liste des utilisateurs';

  @override
  String get activationHistory => 'Historique d\'activation';

  @override
  String get ticketManagement => 'Gestion des tickets';

  @override
  String get zone => 'Zone:';

  @override
  String get wifiName => 'Nom wifi:';

  @override
  String get district => 'Quartier:';

  @override
  String get city => 'Ville:';

  @override
  String get connected => 'Connecté';

  @override
  String get disconnected => 'Déconnecté';

  @override
  String get package => 'Forfait de';

  @override
  String get settingsTitle => 'Paramètre';

  @override
  String get editProfile => 'Modifier Profil';

  @override
  String get changePassword => 'Changer mot de passe';

  @override
  String get privacySettings => 'Paramètre de Confidentialité';

  @override
  String get about => 'A propos';

  @override
  String get french => 'Français';

  @override
  String get english => 'Anglais';

  @override
  String get logout => 'Déconnecter';
}
