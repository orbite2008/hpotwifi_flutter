import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  final _numeroController = TextEditingController();
  final _villeController = TextEditingController();
  String? _pays;
  bool _filled = false;
  String? _errorCountry;
  String? _phoneError;

  final List<String> _paysList = [
    'Bénin',
    'Côte d’Ivoire',
    'France',
    'Togo',
    'Sénégal',
    'Nigéria',
  ];

  @override
  void initState() {
    super.initState();
    _nomController.addListener(_checkFilled);
    _prenomController.addListener(_checkFilled);
    _numeroController.addListener(_checkFilled);
    _villeController.addListener(_checkFilled);
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _numeroController.dispose();
    _villeController.dispose();
    super.dispose();
  }

  void _checkFilled() {
    setState(() {
      _filled = _nomController.text.isNotEmpty &&
          _prenomController.text.isNotEmpty &&
          _numeroController.text.isNotEmpty &&
          _villeController.text.isNotEmpty &&
          _pays != null;
      _errorCountry = null;
      _phoneError = null;
    });
  }

  /// Validation et navigation
  Future<void> _onContinue() async {
    FocusScope.of(context).unfocus();
    final loc = AppLocalizations.of(context)!;

    // ✅ Validation du pays
    if (_pays == null || _pays!.isEmpty) {
      setState(() => _errorCountry = loc.countryRequired);
      return;
    }

    // ✅ Validation du numéro
    final phoneError =
    FormValidators.validatePhone(context, _numeroController.text);
    if (phoneError != null) {
      setState(() => _phoneError = phoneError);
      return;
    }

    // ✅ Affiche le loader
    await showAppLoader(context, message: loc.loading);
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.of(context).pop(); // Ferme le loader

    // ✅ Navigation vers la page de mot de passe
    context.goNamed('registerPassword');
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
            // 🔹 Titre principal
            Text(
              loc.signupCreateAccountTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),

            // 🔹 Champ Nom
            AppTextField(
              hintText: loc.nameLabel,
              controller: _nomController,
            ),
            const SizedBox(height: 16),

            // 🔹 Champ Prénom
            AppTextField(
              hintText: loc.firstnameLabel,
              controller: _prenomController,
            ),
            const SizedBox(height: 16),

            // 🔹 Champ Numéro de téléphone (avec validation)
            AppTextField(
              hintText: loc.phoneLabel,
              controller: _numeroController,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              errorText: _phoneError,
            ),
            const SizedBox(height: 16),

            // 🔹 Champ Ville
            AppTextField(
              hintText: loc.cityLabel,
              controller: _villeController,
            ),
            const SizedBox(height: 16),

            // 🔹 Champ Pays (Dropdown)
            DropdownButtonFormField<String>(
              initialValue: _pays,
              dropdownColor: colors.surface,
              decoration: InputDecoration(
                filled: true,
                fillColor: colors.inputFill,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                hintText: loc.countryLabel,
                hintStyle: AppTextStyles.hint.copyWith(color: colors.hint),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                  borderSide: BorderSide(color: colors.border, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                  borderSide: BorderSide(color: colors.primary, width: 1.3),
                ),
              ),
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  color: colors.textSecondary),
              items: _paysList
                  .map((p) => DropdownMenuItem(
                value: p,
                child: Text(p, style: TextStyle(color: colors.textPrimary)),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() => _pays = value);
                _checkFilled();
              },
            ),

            if (_errorCountry != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorCountry!,
                style: TextStyle(
                  color: colors.error,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],

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

            // 🔹 Lien vers la connexion
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
