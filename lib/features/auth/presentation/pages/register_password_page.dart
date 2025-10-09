import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkFilled);
    _confirmController.addListener(_checkFilled);
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

  /// Validation centralisée et navigation
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

    await showAppLoader(context, message: loc.loading);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.of(context).pop();

    if (mounted) context.goNamed('login');
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
            // Titre principal
            Text(
              loc.signupCreateAccountTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),

            // Champ mot de passe
            AppTextField.password(
              hint: loc.passwordLabel,
              controller: _passwordController,
              errorText: _passwordError,
              onChanged: (_) => _checkFilled(),
            ),
            const SizedBox(height: 16),

            // Champ confirmation mot de passe
            AppTextField.password(
              hint: loc.passwordConfirmLabel,
              controller: _confirmController,
              errorText: _confirmError,
              onChanged: (_) => _checkFilled(),
            ),
            const SizedBox(height: 20),

            // Checkbox Termes et conditions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _acceptedTerms,
                  activeColor: colors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _acceptedTerms = value ?? false;
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

            // Bouton Créer un compte
            AppButton(
              label: loc.createAccountBtn,
              enabled: _filled,
              onPressed: _filled ? _onContinue : null,
              backgroundColor:
              _filled ? colors.buttonActive : colors.buttonInactive,
            ),

            const SizedBox(height: 20),

            // Lien "Déjà un compte ? Connectez-vous"
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
