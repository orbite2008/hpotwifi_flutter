// lib/features/home/presentation/pages/add_hotspot_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/home_controller.dart';
import '../widgets/hotspot_success_dialog.dart';

class AddHotspotPage extends ConsumerStatefulWidget {
  const AddHotspotPage({super.key});

  @override
  ConsumerState<AddHotspotPage> createState() => _AddHotspotPageState();
}

class _AddHotspotPageState extends ConsumerState<AddHotspotPage> {
  final _wifiNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _zoneController = TextEditingController();

  bool _filled = false;

  String? _wifiNameError;
  String? _cityError;
  String? _neighborhoodError;
  String? _zoneError;

  @override
  void initState() {
    super.initState();
    _wifiNameController.addListener(_checkFilled);
    _cityController.addListener(_checkFilled);
    _neighborhoodController.addListener(_checkFilled);
    _zoneController.addListener(_checkFilled);
  }

  void _checkFilled() {
    setState(() {
      _filled = _wifiNameController.text.trim().isNotEmpty &&
          _cityController.text.trim().isNotEmpty &&
          _neighborhoodController.text.trim().isNotEmpty &&
          _zoneController.text.trim().isNotEmpty;

      _wifiNameError = null;
      _cityError = null;
      _neighborhoodError = null;
      _zoneError = null;
    });
  }

  @override
  void dispose() {
    _wifiNameController.dispose();
    _cityController.dispose();
    _neighborhoodController.dispose();
    _zoneController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    FocusScope.of(context).unfocus();
    final loc = AppLocalizations.of(context)!;

    // Validation
    bool hasError = false;

    if (_wifiNameController.text.trim().isEmpty) {
      setState(() => _wifiNameError = loc.fieldRequired);
      hasError = true;
    }

    if (_cityController.text.trim().isEmpty) {
      setState(() => _cityError = loc.fieldRequired);
      hasError = true;
    }

    if (_neighborhoodController.text.trim().isEmpty) {
      setState(() => _neighborhoodError = loc.fieldRequired);
      hasError = true;
    }

    if (_zoneController.text.trim().isEmpty) {
      setState(() => _zoneError = loc.fieldRequired);
      hasError = true;
    }

    if (hasError) return;

    // ✅ Afficher le loader
    await showAppLoader(context, message: loc.loading);

    try {
      // ✅ APPEL API RÉEL
      final newHotspot = await ref.read(homeControllerProvider.notifier).createHotspot(
        hotspotwifiname: _wifiNameController.text.trim(),
        hotspotzonename: _zoneController.text.trim(),
        city: _cityController.text.trim(),
        neighborhood: _neighborhoodController.text.trim(),
      );

      // ✅ Fermer le loader
      if (!mounted) return;
      Navigator.of(context).pop();

      // ✅ Afficher dialog de succès
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => HotspotSuccessDialog(
          wifiName: newHotspot.hotspotwifiname,
          zoneName: newHotspot.hotspotzonename,
          city: newHotspot.city,
          neighborhood: newHotspot.neighborhood,
          routerName: newHotspot.routername,
          routerPortName: newHotspot.routerportname,
          serverName: newHotspot.servername,
        ),
      );

      // Retour Home
      if (mounted) context.pop();
    } catch (e) {
      // ✅ Fermer le loader en cas d'erreur
      if (!mounted) return;
      Navigator.of(context).pop();

      // ✅ Afficher l'erreur
      setState(() {
        _wifiNameError = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AuthAppBar(
          title: loc.addHotspotTitle,
          showReportButton: false,
          showTicketButton: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),

                // Nom du wifi
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

                // Ville et Quartier
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
                            'Quartier',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          AppTextField(
                            controller: _neighborhoodController,
                            hintText: 'Ex: Akpakpa',
                            errorText: _neighborhoodError,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Zone
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
                const SizedBox(height: 40),

                // Bouton
                AppButton(
                  label: loc.addButton,
                  onPressed: _filled ? _onSubmit : null,
                  enabled: _filled,
                  backgroundColor:
                  _filled ? colors.buttonActive : colors.buttonInactive,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
