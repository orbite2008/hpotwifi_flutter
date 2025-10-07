import 'package:flutter/material.dart';
import '../theme/app_theme.dart'; // on utilise l’extension .appColors
import '../theme/app_styles.dart';

/// Champ de saisie réutilisable au style arrondi et adaptatif (light/dark).
class AppTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });

  factory AppTextField.email({
    String hint = 'Email',
    TextEditingController? controller,
    void Function(String)? onChanged,
  }) =>
      AppTextField(
        hintText: hint,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        prefixIcon: const Icon(Icons.email_outlined),
        onChanged: onChanged,
      );

  factory AppTextField.password({
    String hint = 'Mot de passe',
    TextEditingController? controller,
    void Function(String)? onChanged,
  }) =>
      AppTextField(
        hintText: hint,
        controller: controller,
        obscureText: true,
        prefixIcon: const Icon(Icons.lock_outline),
        onChanged: onChanged,
      );

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = false;

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).appColors;

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscured,
      enabled: widget.enabled,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: AppTextStyles.body.copyWith(
        color: widget.enabled ? colors.textPrimary : colors.textSecondary,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.hint.copyWith(color: colors.hint),
        prefixIcon: widget.prefixIcon != null
            ? IconTheme(
          data: IconThemeData(color: colors.hint),
          child: widget.prefixIcon!,
        )
            : null,
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _obscured
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: colors.hint,
          ),
          onPressed: () => setState(() {
            _obscured = !_obscured;
          }),
        )
            : widget.suffixIcon,
        filled: true,
        fillColor: widget.enabled ? colors.inputFill : colors.disabled,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: colors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: colors.primary, width: 1.3),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: colors.border.withOpacity(0.4)),
        ),
      ),
    );
  }
}
