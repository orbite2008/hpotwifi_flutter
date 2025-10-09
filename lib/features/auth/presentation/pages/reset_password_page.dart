import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../l10n/app_localizations.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool _filled = false;
  String? _passwordError;
  String? _confirmError;

  @override
  void initState() {
    super.initState();
    _password.addListener(_checkFilled);
    _confirm.addListener(_checkFilled);
  }

  void _checkFilled() {
    setState(() {
      _filled = _password.text.isNotEmpty && _confirm.text.isNotEmpty;
      _passwordError = null;
      _confirmError = null;
    });
  }

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final loc = AppLocalizations.of(context)!;
    FocusScope.of(context).unfocus();

    setState(() {
      _passwordError = null;
      _confirmError = null;
    });

    if (_password.text.isEmpty) {
      setState(() => _passwordError = loc.passwordRequired);
      return;
    }

    if (_password.text.length < 6) {
      setState(() => _passwordError = loc.passwordTooShort);
      return;
    }

    if (_password.text != _confirm.text) {
      setState(() => _confirmError = loc.passwordMismatch);
      return;
    }

    await showAppLoader(context, message: loc.loading);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.of(context).pop(); // ferme le loader

    // Navigation vers la page de login après succès
    if (mounted) context.goNamed('resetSuccess');
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
              loc.resetPasswordTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              loc.resetPasswordSubtitle,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 24),

            // Champ nouveau mot de passe
            AppTextField.password(
              controller: _password,
              hint: loc.passwordLabel,
              errorText: _passwordError,
              onChanged: (_) => _checkFilled(),
            ),
            const SizedBox(height: 16),

            // Champ confirmation mot de passe
            AppTextField.password(
              controller: _confirm,
              hint: loc.passwordConfirmLabel,
              errorText: _confirmError,
              onChanged: (_) => _checkFilled(),
            ),
            const SizedBox(height: 24),

            // Bouton de validation
            AppButton(
              label: loc.resetPasswordButton,
              enabled: _filled,
              onPressed: _filled ? _onSubmit : null,
              backgroundColor:
              _filled ? colors.buttonActive : colors.buttonInactive,
            ),
          ],
        ),
      ),
    );
  }
}
