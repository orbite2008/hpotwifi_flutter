import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/services.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../../l10n/app_localizations.dart';

class RegisterDetailsPage extends ConsumerStatefulWidget {
  const RegisterDetailsPage({super.key});

  @override
  ConsumerState<RegisterDetailsPage> createState() =>
      _RegisterDetailsPageState();
}

class _RegisterDetailsPageState extends ConsumerState<RegisterDetailsPage> {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _villeController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _fullPhone;
  final String _countryCode = '229';
  bool _filled = false;
  String? _phoneError;

  late final String _email;
  bool _initialized = false; // évite la double initialisation

  @override
  void initState() {
    super.initState();
    _nomController.addListener(_checkFilled);
    _prenomController.addListener(_checkFilled);
    _villeController.addListener(_checkFilled);
    _phoneController.addListener(_checkFilled);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final extra = GoRouterState.of(context).extra;
    if (extra is Map && extra['email'] is String) {
      _email = extra['email'] as String;
    } else {
      _email = '';
    }

    _initialized = true;
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _villeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _checkFilled() {
    setState(() {
      _filled = _nomController.text.isNotEmpty &&
          _prenomController.text.isNotEmpty &&
          _villeController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty;
      _phoneError = null;
    });
  }

  /// ✅ Vérifie que le numéro fait 10 chiffres et commence par "01"
  bool _isValidBeninPhone(String phone) {
    final regex = RegExp(r'^01\d{8}$'); // commence par 01 + 8 chiffres
    return regex.hasMatch(phone);
  }

  Future<void> _onContinue() async {
    FocusScope.of(context).unfocus();
    final loc = AppLocalizations.of(context)!;

    final phone = _phoneController.text.trim();

    if (!_isValidBeninPhone(phone)) {
      setState(() => _phoneError =
      "Le numéro doit commencer par 01 et comporter 10 chiffres.");
      return;
    }

    _fullPhone = '+$_countryCode$phone';

    await showAppLoader(context, message: loc.loading);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.of(context).pop();

    context.goNamed('registerPassword', extra: {
      'email': _email,
      'firstName': _prenomController.text.trim(),
      'lastName': _nomController.text.trim(),
      'city': _villeController.text.trim(),
      'phonenumber': _fullPhone,
      'countryCode': _countryCode,
    });
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
            // 🔹 Titre
            Text(
              loc.signupCreateAccountTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),

            // 🔹 Nom
            AppTextField(
              hintText: loc.nameLabel,
              controller: _nomController,
            ),
            const SizedBox(height: 16),

            // 🔹 Prénom
            AppTextField(
              hintText: loc.firstnameLabel,
              controller: _prenomController,
            ),
            const SizedBox(height: 16),

            // 🔹 Téléphone (pays complètement verrouillé sur le Bénin)
            Stack(
              children: [
                IntlPhoneField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: "01XXXXXXXX",
                    hintStyle: AppTextStyles.hint.copyWith(color: colors.hint),
                    filled: true,
                    fillColor: colors.inputFill,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                      borderSide: BorderSide(
                        color:
                        _phoneError != null ? colors.error : colors.border,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                      borderSide: BorderSide(
                        color: _phoneError != null
                            ? colors.error
                            : colors.primary,
                        width: 1.3,
                      ),
                    ),
                    errorText: _phoneError,
                  ),
                  initialCountryCode: 'BJ',
                  disableLengthCheck: true,

                  // 🔒 VERROUILLAGE COMPLET DU SÉLECTEUR
                  showDropdownIcon: false,
                  flagsButtonPadding:
                  const EdgeInsets.only(left: 12, right: 8),

                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (phone) => _checkFilled(),
                  onCountryChanged: (country) {
                    if (country.code != 'BJ') {
                      Future.microtask(() {
                        _phoneController.clear();
                        setState(() {});
                      });
                    }
                  },
                ),

                Positioned(
                  left: 0,
                  top: 0,
                  bottom: _phoneError != null ? 24 : 0,
                  width: 90,
                  child: Container(color: Colors.transparent),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 🔹 Ville
            AppTextField(
              hintText: loc.cityLabel,
              controller: _villeController,
            ),

            const SizedBox(height: 32),

            // 🔹 Bouton continuer
            AppButton(
              label: loc.continueBtn,
              enabled: _filled,
              onPressed: _filled ? _onContinue : null,
              backgroundColor:
              _filled ? colors.buttonActive : colors.buttonInactive,
            ),

            const SizedBox(height: 24),

            // 🔹 Lien connexion
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  loc.signupHaveAccount,
                  style:
                  TextStyle(color: colors.textSecondary, fontSize: 15),
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
