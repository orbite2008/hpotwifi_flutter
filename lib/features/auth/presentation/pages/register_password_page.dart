import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/providers/global_providers.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../l10n/app_localizations.dart';

class RegisterPasswordPage extends ConsumerStatefulWidget {
  const RegisterPasswordPage({super.key});

  @override
  ConsumerState<RegisterPasswordPage> createState() =>
      _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends ConsumerState<RegisterPasswordPage> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _acceptedTerms = false;
  bool _filled = false;

  String? _passwordError;
  String? _confirmError;
  String? _termsError;

  late final String _email;
  late final String _firstName;
  late final String _lastName;
  late final String _city;
  late final String _phoneNumber;
  late final String _countryCode;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkFilled);
    _confirmController.addListener(_checkFilled);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final extra = GoRouterState.of(context).extra;
    if (extra is Map<String, dynamic>) {
      _email = extra['email'] ?? '';
      _firstName = extra['firstName'] ?? '';
      _lastName = extra['lastName'] ?? '';
      _city = extra['city'] ?? '';
      _phoneNumber = extra['phonenumber'] ?? '';
      _countryCode = extra['countryCode'] ?? '229';
    } else {
      _email = '';
      _firstName = '';
      _lastName = '';
      _city = '';
      _phoneNumber = '';
      _countryCode = '229';
    }

    _initialized = true;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _checkFilled() {
    setState(() {
      _filled = _passwordController.text.isNotEmpty &&
          _confirmController.text.isNotEmpty &&
          _acceptedTerms;
      _passwordError = null;
      _confirmError = null;
      _termsError = null;
    });
  }

  Future<void> _onContinue() async {
    final loc = AppLocalizations.of(context)!;
    FocusScope.of(context).unfocus();

    setState(() {
      _passwordError = null;
      _confirmError = null;
      _termsError = null;
    });

    final passwordError =
    FormValidators.validatePassword(context, _passwordController.text);
    if (passwordError != null) {
      setState(() => _passwordError = passwordError);
      return;
    }

    if (_passwordController.text != _confirmController.text) {
      setState(() => _confirmError = loc.passwordMismatch);
      return;
    }

    if (!_acceptedTerms) {
      setState(() => _termsError = loc.termsRequired);
      return;
    }

    final authController = ref.read(authControllerProvider.notifier);

    await showAppLoader(context, message: loc.loading);
    final success = await authController.register(
      firstName: _firstName,
      lastName: _lastName,
      email: _email,
      password: _passwordController.text,
      phonenumber: _phoneNumber,
      city: _city,
      countryCode: _countryCode,
    );
    if (mounted) Navigator.of(context).pop();

    if (success) {
      await _showSuccessDialog(loc);
    } else {
      final state = ref.read(authControllerProvider);
      await _showErrorDialog(state.errorMessage ?? loc.otpSendFailed);
    }
  }

  Future<void> _showSuccessDialog(AppLocalizations loc) async {
    final colors = AppColors.of(context);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: colors.buttonActive,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                loc.accountCreatedMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                loc.signupEnterEmailSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: "OK",
                onPressed: () {
                  Navigator.of(context).pop();
                  context.goNamed('login');
                },
                backgroundColor: colors.buttonActive,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Dialogue d’erreur
  Future<void> _showErrorDialog(String message) async {
    final colors = AppColors.of(context);

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: colors.error,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                "Échec de l’inscription",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: "Réessayer",
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: colors.buttonActive,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AuthAppBar(title: loc.appTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.signupCreateAccountTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            AppTextField.password(
              hint: loc.passwordLabel,
              controller: _passwordController,
              errorText: _passwordError,
              onChanged: (_) => _checkFilled(),
            ),
            const SizedBox(height: 16),
            AppTextField.password(
              hint: loc.passwordConfirmLabel,
              controller: _confirmController,
              errorText: _confirmError,
              onChanged: (_) => _checkFilled(),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _acceptedTerms,
                  activeColor: colors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (v) {
                    setState(() {
                      _acceptedTerms = v ?? false;
                      _checkFilled();
                    });
                  },
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(text: loc.termsDescription),
                            const TextSpan(text: " "),
                            TextSpan(
                              text: loc.termsAndConditions,
                              style: TextStyle(
                                color: colors.buttonActive,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_termsError != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          _termsError!,
                          style: TextStyle(
                            color: colors.error,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppButton(
              label: loc.createAccountBtn,
              enabled: _filled,
              onPressed: _filled ? _onContinue : null,
              backgroundColor:
              _filled ? colors.buttonActive : colors.buttonInactive,
            ),
            const SizedBox(height: 20),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  loc.signupHaveAccount,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => context.goNamed('login'),
                  child: Text(
                    loc.loginLink,
                    style: TextStyle(
                      color: colors.buttonActive,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
