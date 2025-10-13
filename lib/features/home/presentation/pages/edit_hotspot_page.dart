// lib/features/edit_hotspot/presentation/pages/edit_hotspot_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../l10n/app_localizations.dart';

class EditHotspotPage extends StatefulWidget {
  const EditHotspotPage({super.key});

  @override
  State<EditHotspotPage> createState() => _EditHotspotPageState();
}

class _EditHotspotPageState extends State<EditHotspotPage> {
  // Controllers avec données préchargées
  final _wifiNameController = TextEditingController(text: 'Wifi Zone1');
  final _cityController = TextEditingController(text: 'Cotonou');
  final _districtController = TextEditingController(text: 'Agla');
  final _zoneController = TextEditingController(text: '2eme rue');
  final _descriptionController = TextEditingController(
    text: 'Utilisation parfaite et guide parfait',
  );

  // Données en lecture seule (affichées en haut)
  final String serverName = 'Cotonou';
  final String routerName = 'Agla';
  final String bridgeName = '2ème rue';

  bool _filled = true;

  String? _wifiNameError;
  String? _cityError;
  String? _districtError;
  String? _zoneError;

  @override
  void initState() {
    super.initState();
    _wifiNameController.addListener(_checkFilled);
    _cityController.addListener(_checkFilled);
    _districtController.addListener(_checkFilled);
    _zoneController.addListener(_checkFilled);
    _descriptionController.addListener(_checkFilled);
  }

  void _checkFilled() {
    setState(() {
      _filled = _wifiNameController.text.trim().isNotEmpty &&
          _cityController.text.trim().isNotEmpty &&
          _districtController.text.trim().isNotEmpty &&
          _zoneController.text.trim().isNotEmpty;

      _wifiNameError = null;
      _cityError = null;
      _districtError = null;
      _zoneError = null;
    });
  }

  @override
  void dispose() {
    _wifiNameController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _zoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();

    final loc = AppLocalizations.of(context)!;

    bool hasError = false;

    if (_wifiNameController.text.trim().isEmpty) {
      setState(() => _wifiNameError = loc.fieldRequired);
      hasError = true;
    }

    if (_cityController.text.trim().isEmpty) {
      setState(() => _cityError = loc.fieldRequired);
      hasError = true;
    }

    if (_districtController.text.trim().isEmpty) {
      setState(() => _districtError = loc.fieldRequired);
      hasError = true;
    }

    if (_zoneController.text.trim().isEmpty) {
      setState(() => _zoneError = loc.fieldRequired);
      hasError = true;
    }

    if (hasError) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loc.hotspotUpdatedSuccess),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          backgroundColor: colors.surface,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colors.textPrimary),
            onPressed: () => context.pop(),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                loc.editHotspotTitle,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ===== Carte d'informations en lecture seule =====
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildInfoRow(loc.serverNameLabel, serverName, colors),
                      const SizedBox(height: 12),
                      _buildInfoRow(loc.routerNameLabel, routerName, colors),
                      const SizedBox(height: 12),
                      _buildInfoRow(loc.bridgeNameLabel, bridgeName, colors),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ===== Nom du wifi =====
                Text(
                  loc.wifiNameLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _wifiNameController,
                  hintText: loc.wifiNameHint,
                  errorText: _wifiNameError,
                ),

                const SizedBox(height: 24),

                // ===== Ville et Quartier =====
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.cityLabel,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: _cityController,
                            hintText: loc.cityHint,
                            errorText: _cityError,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.districtLabel,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: _districtController,
                            hintText: loc.districtHint,
                            errorText: _districtError,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ===== Zone =====
                Text(
                  loc.zoneLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _zoneController,
                  hintText: loc.zoneHint,
                  errorText: _zoneError,
                ),

                const SizedBox(height: 24),

                // ===== Description =====
                Text(
                  loc.descriptionLabel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                AppTextField(
                  controller: _descriptionController,
                  hintText: loc.descriptionHint,
                  maxLines: 5,
                ),

                const SizedBox(height: 40),

                // ===== Bouton Modifier =====
                AppButton(
                  label: loc.editButton,
                  onPressed: _filled ? _onSubmit : null,
                  backgroundColor: _filled ? colors.primary : colors.disabled,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget pour afficher une ligne d'information
  Widget _buildInfoRow(String label, String value, AppColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
