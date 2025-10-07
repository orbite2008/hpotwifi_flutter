import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/otp_dialog.dart';
import 'package:go_router/go_router.dart';

class RegisterEmailPage extends ConsumerStatefulWidget {
  const RegisterEmailPage({super.key});

  @override
  ConsumerState<RegisterEmailPage> createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends ConsumerState<RegisterEmailPage> {
  final _email = TextEditingController();
  bool _filled = false;

  @override
  void initState() {
    super.initState();
    _email.addListener(() {
      setState(() => _filled = _email.text.trim().isNotEmpty);
    });
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AuthAppBar(title: loc.appTitle),
      body: Padding(
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
            const SizedBox(height: 8),
            Text(
              loc.signupEnterEmailSubtitle,
              style: TextStyle(fontSize: 15, color: colors.textSecondary),
            ),
            const SizedBox(height: 32),
            AppTextField.email(controller: _email),
            const SizedBox(height: 24),
            AppButton(
              label: loc.continueBtn,
              onPressed: _filled
                  ? () async {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(loc.signupSendingCode)),
                );
                await Future.delayed(const Duration(seconds: 1));
                if (!mounted) return;
                await showOtpDialog(context, _email.text.trim());
              }
                  : null,
              enabled: _filled,
              backgroundColor:
              _filled ? colors.buttonActive : colors.buttonInactive,
            ),
            const SizedBox(height: 20),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  loc.signupHaveAccount,
                  style: TextStyle(color: colors.textSecondary, fontSize: 15),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => context.goNamed('login'),
                  child: Text(
                    loc.loginLink,
                    style: const TextStyle(
                      color: Color(0xFF0C60AF),
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
