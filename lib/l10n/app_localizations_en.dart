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
  String get signupSendingCode => 'Sending verification code...';

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
}
