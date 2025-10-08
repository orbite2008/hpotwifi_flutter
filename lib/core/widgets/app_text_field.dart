import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_styles.dart';

/// Champ de saisie réutilisable et homogène dans tout le projet.
class AppTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.onChanged,
    this.inputFormatters,
  });

  /// Champ préconfiguré pour e-mail
  factory AppTextField.email({
    String hint = 'Email',
    TextEditingController? controller,
    String? errorText,
    void Function(String)? onChanged,
  }) =>
      AppTextField(
        hintText: hint,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        prefixIcon: const Icon(Icons.email_outlined),
        errorText: errorText,
        onChanged: onChanged,
      );

  /// Champ préconfiguré pour mot de passe
  factory AppTextField.password({
    String hint = 'Mot de passe',
    TextEditingController? controller,
    String? errorText,
    void Function(String)? onChanged,
  }) =>
      AppTextField(
        hintText: hint,
        controller: controller,
        obscureText: true,
        prefixIcon: const Icon(Icons.lock_outline),
        errorText: errorText,
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
    final colors = AppColors.of(context);

    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscured,
      enabled: widget.enabled,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      style: AppTextStyles.body.copyWith(
        color: widget.enabled ? colors.textPrimary : colors.textSecondary,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.hint.copyWith(color: colors.hint),
        errorText: widget.errorText,
        errorStyle: TextStyle(
          color: colors.error,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
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
          onPressed: () => setState(() => _obscured = !_obscured),
        )
            : widget.suffixIcon,
        filled: true,
        fillColor: widget.enabled ? colors.inputFill : colors.disabled,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        // Bordures adaptatives
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: colors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: colors.primary, width: 1.3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: colors.error, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          borderSide: BorderSide(color: colors.error, width: 1.3),
        ),
      ),
    );
  }
}
