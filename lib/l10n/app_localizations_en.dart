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
  String get darkMode => 'Dark mode';

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
  String get forgotPasswordTitle => 'Reset your password';

  @override
  String get forgotPasswordSubtitle => 'Please enter the email address associated with your account and we will send you a link to reset your password.';

  @override
  String get backToLogin => 'Back to login page';

  @override
  String get continueButton => 'Continue';

  @override
  String get resetLinkSent => 'Reset link sent!';

  @override
  String get checkYourEmail => 'Check your email inbox.';
}
