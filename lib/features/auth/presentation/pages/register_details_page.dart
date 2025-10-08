import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class RegisterDetailsPage extends ConsumerStatefulWidget {
  const RegisterDetailsPage({super.key});

  @override
  ConsumerState<RegisterDetailsPage> createState() =>
      _RegisterDetailsPageState();
}

class _RegisterDetailsPageState extends ConsumerState<RegisterDetailsPage> {
  final _nom = TextEditingController();
  final _prenom = TextEditingController();
  final _numero = TextEditingController();
  final _ville = TextEditingController();
  String? _pays;
  bool _filled = false;
  String? _error;

  final List<String> _paysList = [
    'Bénin',
    'Côte d’Ivoire',
    'France',
    'Togo',
    'Sénégal',
    'Nigéria',
  ];

  void _checkFilled() {
    setState(() {
      _filled = _nom.text.isNotEmpty &&
          _prenom.text.isNotEmpty &&
          _numero.text.isNotEmpty &&
          _ville.text.isNotEmpty &&
          _pays != null;
      _error = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _nom.addListener(_checkFilled);
    _prenom.addListener(_checkFilled);
    _numero.addListener(_checkFilled);
    _ville.addListener(_checkFilled);
  }

  @override
  void dispose() {
    _nom.dispose();
    _prenom.dispose();
    _numero.dispose();
    _ville.dispose();
    super.dispose();
  }

  /// Validation et navigation
  Future<void> _onContinue() async {
    FocusScope.of(context).unfocus();
    final loc = AppLocalizations.of(context)!;

    if (_pays == null || _pays!.isEmpty) {
      setState(() => _error = loc.countryRequired);
      return;
    }

    await showAppLoader(context, message: loc.loading);
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.of(context).pop();

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

            // Champ Nom
            AppTextField(
              hintText: loc.nameLabel,
              controller: _nom,
            ),
            const SizedBox(height: 16),

            // Champ Prénom
            AppTextField(
              hintText: loc.firstnameLabel,
              controller: _prenom,
            ),
            const SizedBox(height: 16),

            // Champ Numéro (chiffres uniquement)
            AppTextField(
              hintText: loc.phoneLabel,
              controller: _numero,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),

            // Champ Ville
            AppTextField(
              hintText: loc.cityLabel,
              controller: _ville,
            ),
            const SizedBox(height: 16),

            // Champ Pays (Dropdown stylisé)
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
                child: Text(
                  p,
                  style: TextStyle(color: colors.textPrimary),
                ),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() => _pays = value);
                _checkFilled();
              },
            ),

            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: TextStyle(
                  color: colors.error,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],

            const SizedBox(height: 32),

            // Bouton continuer
            AppButton(
              label: loc.continueBtn,
              enabled: _filled,
              onPressed: _filled ? _onContinue : null,
              backgroundColor:
              _filled ? colors.buttonActive : colors.buttonInactive,
            ),

            const SizedBox(height: 24),

            // Lien "Déjà un compte ?"
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
