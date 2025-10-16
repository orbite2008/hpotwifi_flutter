// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'HpotWiFi';

  @override
  String get welcome => 'Welcome to Hotspot Wifi';

  @override
  String get language => 'Language';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get loading => 'Loading...';

  @override
  String get signupCreateAccountTitle => 'Create account';

  @override
  String get signupEnterEmailSubtitle => 'Enter your email for validation';

  @override
  String get continueBtn => 'Continue';

  @override
  String get signupHaveAccount => 'Already have an account?';

  @override
  String get loginLink => 'Log in';

  @override
  String get signupInvalidEmail => 'Invalid email address. Please try again.';

  @override
  String get countryRequired => 'Please select a country.';

  @override
  String get otpSendFailed => 'Failed to send verification code. Please try again.';

  @override
  String get otpSendSuccess => 'Verification code sent successfully.';

  @override
  String get otpTitle => 'Code verification';

  @override
  String get otpSubtitle => 'We just sent a verification code to';

  @override
  String get otpPlaceholder => 'Enter the 5-digit code';

  @override
  String get otpButton => 'Verify';

  @override
  String get otpInvalid => 'Invalid code. Please try again.';

  @override
  String get resendCodeBtn => 'Resend code';

  @override
  String get nameLabel => 'Last name';

  @override
  String get firstnameLabel => 'First name';

  @override
  String get phoneLabel => 'Phone number';

  @override
  String get cityLabel => 'City';

  @override
  String get countryLabel => 'Country';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordConfirmLabel => 'Confirm password';

  @override
  String get passwordRequired => 'Password is required.';

  @override
  String get passwordMismatch => 'Passwords do not match.';

  @override
  String get termsDescription => 'By continuing, you agree to the';

  @override
  String get termsAndConditions => 'terms and conditions';

  @override
  String get termsRequired => 'You must accept the terms.';

  @override
  String get createAccountBtn => 'Create account';

  @override
  String get accountCreatedMessage => 'Account created successfully!';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginSubtitle => 'Enter your credentials to log in';

  @override
  String get emailLabel => 'Email';

  @override
  String get loginBtn => 'Login';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get signupLink => 'Sign up';

  @override
  String get invalidCredentials => 'Invalid email or password.';

  @override
  String get emailRequired => 'Email is required.';

  @override
  String get loginSuccess => 'Login successful!';

  @override
  String get loginFailed => 'Login failed. Please check your information.';

  @override
  String get forgotPasswordTitle => 'Forgot your password?';

  @override
  String get forgotPasswordSubtitle => 'Enter your email address to receive a reset link.';

  @override
  String get resetLinkSent => 'Password reset link sent!';

  @override
  String get checkYourEmail => 'Please check your email inbox to continue.';

  @override
  String get resetPasswordTitle => 'Create a new password';

  @override
  String get resetPasswordSubtitle => 'Please enter your new password';

  @override
  String get resetPasswordButton => 'Change password';

  @override
  String get passwordResetSuccessTitle => 'Your password has been successfully updated.';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters long.';

  @override
  String get passwordConfirmRequired => 'Please confirm your password.';

  @override
  String get phoneRequired => 'Phone number is required.';

  @override
  String get phoneInvalid => 'Invalid phone number.';

  @override
  String greeting(Object name) {
    return 'Hi, $name!';
  }

  @override
  String get searchHotspots => 'Search hotspots';

  @override
  String get myHotspots => 'My hotspots';

  @override
  String wifiZone(Object number) {
    return 'Wifi Zone $number';
  }

  @override
  String get noHotspotsTitle => 'No hotspots';

  @override
  String get noHotspotsMessage => 'You don\'t have any hotspots yet. Start by creating one!';

  @override
  String get addFirstHotspot => 'Add my first hotspot';

  @override
  String get vendor => 'Vendor';

  @override
  String get pullToRefresh => 'Pull to refresh';

  @override
  String get dailySale => 'Daily sale';

  @override
  String get online => 'online';

  @override
  String get users => 'users';

  @override
  String get owner => 'Owner';

  @override
  String get assistant => 'Assistant';

  @override
  String get fcfa => 'f';

  @override
  String get noSearchResults => 'No results found';

  @override
  String noSearchResultsMessage(Object query) {
    return 'No hotspot matches \"$query\".\nTry a different search term.';
  }

  @override
  String get addHotspot => 'Add a hotspot';

  @override
  String get packageManagement => 'Package management';

  @override
  String get mySellers => 'My sellers';

  @override
  String get manageTickets => 'Ticket management';

  @override
  String get report => 'Report';

  @override
  String get myProfile => 'My profile';

  @override
  String get hotspotCreatedTitle => 'Hotspot created!';

  @override
  String hotspotCreatedMessage(Object name) {
    return 'The hotspot \"$name\" has been successfully created.';
  }

  @override
  String get copy => 'Copy';

  @override
  String get ok => 'OK';

  @override
  String get addHotspotTitle => 'Add a hotspot';

  @override
  String get wifiNameLabel => 'Wifi name';

  @override
  String get wifiNameHint => 'Enter the wifi name';

  @override
  String get cityHint => 'City';

  @override
  String get zoneLabel => 'Zone';

  @override
  String get zoneHint => 'Zone';

  @override
  String get addButton => 'Add';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get filters => 'Filters';

  @override
  String get apply => 'Apply';

  @override
  String get cancel => 'Cancel';

  @override
  String get graphComingSoon => 'Graph coming soon';

  @override
  String get noUsersFound => 'No users found';

  @override
  String get retry => 'Retry';

  @override
  String get editHotspotTitle => 'Edit a hotspot';

  @override
  String get serverNameLabel => 'Server name:';

  @override
  String get routerNameLabel => 'Router name:';

  @override
  String get bridgeNameLabel => 'Bridge name:';

  @override
  String get editButton => 'Edit';

  @override
  String get editableFieldsLabel => 'Editable fields';

  @override
  String get hotspotActiveLabel => 'Hotspot active';

  @override
  String get saveChangesButton => 'Save changes';

  @override
  String get backButton => 'Back';

  @override
  String get districtLabel => 'District';

  @override
  String get error => 'Error';

  @override
  String get graph => 'Graph';

  @override
  String get userList => 'User list';

  @override
  String get activationHistory => 'Activation history';

  @override
  String get ticketManagement => 'Ticket management';

  @override
  String get zone => 'Zone:';

  @override
  String get wifiName => 'Wifi name:';

  @override
  String get district => 'District:';

  @override
  String get city => 'City:';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get package => 'Package';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changePassword => 'Change Password';

  @override
  String get privacySettings => 'Privacy Settings';

  @override
  String get about => 'About';

  @override
  String get french => 'French';

  @override
  String get english => 'English';

  @override
  String get logout => 'Logout';
}
