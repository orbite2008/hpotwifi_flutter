import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'HpotWiFi'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Hotspot Wifi'**
  String get welcome;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @signupCreateAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signupCreateAccountTitle;

  /// No description provided for @signupEnterEmailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email for validation'**
  String get signupEnterEmailSubtitle;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @signupHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get signupHaveAccount;

  /// No description provided for @loginLink.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginLink;

  /// No description provided for @signupInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address. Please try again.'**
  String get signupInvalidEmail;

  /// No description provided for @countryRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a country.'**
  String get countryRequired;

  /// No description provided for @otpSendFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send verification code. Please try again.'**
  String get otpSendFailed;

  /// No description provided for @otpSendSuccess.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent successfully.'**
  String get otpSendSuccess;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Code verification'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We just sent a verification code to'**
  String get otpSubtitle;

  /// No description provided for @otpPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter the 5-digit code'**
  String get otpPlaceholder;

  /// No description provided for @otpButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpButton;

  /// No description provided for @otpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid code. Please try again.'**
  String get otpInvalid;

  /// No description provided for @resendCodeBtn.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCodeBtn;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get nameLabel;

  /// No description provided for @firstnameLabel.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstnameLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneLabel;

  /// No description provided for @cityLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityLabel;

  /// No description provided for @countryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get countryLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get passwordConfirmLabel;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required.'**
  String get passwordRequired;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordMismatch;

  /// No description provided for @termsDescription.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to the'**
  String get termsDescription;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'terms and conditions'**
  String get termsAndConditions;

  /// No description provided for @termsRequired.
  ///
  /// In en, this message translates to:
  /// **'You must accept the terms.'**
  String get termsRequired;

  /// No description provided for @createAccountBtn.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountBtn;

  /// No description provided for @accountCreatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreatedMessage;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials to log in'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @loginBtn.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginBtn;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @signupLink.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signupLink;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get invalidCredentials;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required.'**
  String get emailRequired;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccess;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your information.'**
  String get loginFailed;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to receive a reset link.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Send link'**
  String get continueButton;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent!'**
  String get resetLinkSent;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please check your email inbox to continue.'**
  String get checkYourEmail;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter your new password'**
  String get resetPasswordSubtitle;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get resetPasswordButton;

  /// No description provided for @passwordResetSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Your password has been successfully updated.'**
  String get passwordResetSuccessTitle;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long.'**
  String get passwordTooShort;

  /// No description provided for @passwordConfirmRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password.'**
  String get passwordConfirmRequired;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required.'**
  String get phoneRequired;

  /// No description provided for @phoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number.'**
  String get phoneInvalid;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}!'**
  String greeting(String name);

  /// No description provided for @searchHotspots.
  ///
  /// In en, this message translates to:
  /// **'Search hotspots'**
  String get searchHotspots;

  /// No description provided for @myHotspots.
  ///
  /// In en, this message translates to:
  /// **'My hotspots'**
  String get myHotspots;

  /// No description provided for @wifiZone.
  ///
  /// In en, this message translates to:
  /// **'Wifi Zone {number}'**
  String wifiZone(String number);

  /// No description provided for @dailySale.
  ///
  /// In en, this message translates to:
  /// **'Daily sale'**
  String get dailySale;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'online'**
  String get online;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'users'**
  String get users;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @assistant.
  ///
  /// In en, this message translates to:
  /// **'Assistant'**
  String get assistant;

  /// No description provided for @fcfa.
  ///
  /// In en, this message translates to:
  /// **'f'**
  String get fcfa;

  /// No description provided for @addHotspot.
  ///
  /// In en, this message translates to:
  /// **'Add a hotspot'**
  String get addHotspot;

  /// No description provided for @packageManagement.
  ///
  /// In en, this message translates to:
  /// **'Package management'**
  String get packageManagement;

  /// No description provided for @mySellers.
  ///
  /// In en, this message translates to:
  /// **'My sellers'**
  String get mySellers;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @manageTickets.
  ///
  /// In en, this message translates to:
  /// **'Ticket management'**
  String get manageTickets;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get myProfile;

  /// No description provided for @addHotspotTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a hotspot'**
  String get addHotspotTitle;

  /// No description provided for @wifiNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Wifi name'**
  String get wifiNameLabel;

  /// No description provided for @wifiNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the wifi name'**
  String get wifiNameHint;

  /// No description provided for @cityHint.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityHint;

  /// No description provided for @districtLabel.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get districtLabel;

  /// No description provided for @districtHint.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get districtHint;

  /// No description provided for @zoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get zoneLabel;

  /// No description provided for @zoneHint.
  ///
  /// In en, this message translates to:
  /// **'Zone'**
  String get zoneHint;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionHint;

  /// No description provided for @addButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addButton;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @hotspotWillBeCreated.
  ///
  /// In en, this message translates to:
  /// **'Hotspot \"{name}\" will be created (feature to be implemented)'**
  String hotspotWillBeCreated(String name);

  /// No description provided for @editHotspotTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit a hotspot'**
  String get editHotspotTitle;

  /// No description provided for @serverNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Server name:'**
  String get serverNameLabel;

  /// No description provided for @routerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Router name:'**
  String get routerNameLabel;

  /// No description provided for @bridgeNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Bridge name:'**
  String get bridgeNameLabel;

  /// No description provided for @editButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editButton;

  /// No description provided for @hotspotUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Hotspot updated successfully (feature to be implemented)'**
  String get hotspotUpdatedSuccess;

  /// No description provided for @graph.
  ///
  /// In en, this message translates to:
  /// **'Graph'**
  String get graph;

  /// No description provided for @userList.
  ///
  /// In en, this message translates to:
  /// **'User list'**
  String get userList;

  /// No description provided for @activationHistory.
  ///
  /// In en, this message translates to:
  /// **'Activation history'**
  String get activationHistory;

  /// No description provided for @ticketManagement.
  ///
  /// In en, this message translates to:
  /// **'Ticket management'**
  String get ticketManagement;

  /// No description provided for @zone.
  ///
  /// In en, this message translates to:
  /// **'Zone:'**
  String get zone;

  /// No description provided for @wifiName.
  ///
  /// In en, this message translates to:
  /// **'Wifi name:'**
  String get wifiName;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District:'**
  String get district;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City:'**
  String get city;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// No description provided for @package.
  ///
  /// In en, this message translates to:
  /// **'Package'**
  String get package;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
