// lib/features/home/presentation/pages/edit_hotspot_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/hotspot_entity.dart';
import '../controllers/hotspot_detail_controller.dart';
import '../controllers/edit_hotspot_controller.dart';
import '../controllers/home_controller.dart';

class EditHotspotPage extends ConsumerStatefulWidget {
  final int hotspotId;

  const EditHotspotPage({super.key, required this.hotspotId});

  @override
  ConsumerState<EditHotspotPage> createState() => _EditHotspotPageState();
}

class _EditHotspotPageState extends ConsumerState<EditHotspotPage> {
  late TextEditingController _cityController;
  late bool _enable;

  String _initialCity = '';
  bool _initialEnable = false;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
    _cityController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  bool get _hasChanges {
    return _cityController.text.trim() != _initialCity ||
        _enable != _initialEnable;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    final hotspotAsync = ref.watch(hotspotDetailControllerProvider(widget.hotspotId));

    return hotspotAsync.when(
      loading: () => Scaffold(
        backgroundColor: colors.background,
        body: const AppLoader(),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: colors.background,
        appBar: _CustomAppBar(
          title: loc.error,
          colors: colors,
          onBack: () => context.pop(),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 80, color: colors.error),
                const SizedBox(height: 16),
                Text(
                  error.toString(),
                  style: TextStyle(color: colors.error, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                AppButton(
                  label: loc.backButton,
                  onPressed: () => context.pop(),
                  backgroundColor: colors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
      data: (hotspot) {
        if (_initialCity.isEmpty) {
          _initialCity = hotspot.city;
          _initialEnable = hotspot.enable;
          _cityController.text = hotspot.city;
          _enable = hotspot.enable;
        }

        return _buildContent(hotspot, colors, loc);
      },
    );
  }

  Widget _buildContent(HotspotEntity hotspot, AppColors colors, AppLocalizations loc) {
    final editState = ref.watch(editHotspotControllerProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: _CustomAppBar(
          title: loc.editHotspotTitle,
          colors: colors,
          onBack: () => context.pop(),
          icon: Icons.edit,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ═══════════════════════════════════════════════════
                // INFORMATIONS NON MODIFIABLES
                // ═══════════════════════════════════════════════════
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.disabled.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors.border),
                  ),
                  child: Column(
                    children: [
                      _buildDisabledRow(loc.serverNameLabel, hotspot.servername, colors),
                      const SizedBox(height: 12),
                      _buildDisabledRow(loc.routerNameLabel, hotspot.routername, colors),
                      const SizedBox(height: 12),
                      _buildDisabledRow(loc.bridgeNameLabel, hotspot.routerportname, colors),
                      const SizedBox(height: 12),
                      _buildDisabledRow(loc.wifiNameLabel, hotspot.hotspotwifiname, colors),
                      const SizedBox(height: 12),
                      _buildDisabledRow(loc.districtLabel, hotspot.neighborhood, colors),
                      const SizedBox(height: 12),
                      _buildDisabledRow(loc.zoneLabel, hotspot.hotspotzonename, colors),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // ═══════════════════════════════════════════════════
                // TITRE SECTION MODIFIABLE
                // ═══════════════════════════════════════════════════
                Text(
                  loc.editableFieldsLabel,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),

                const SizedBox(height: 16),

                // ✏️ Ville (éditable)
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
                ),

                const SizedBox(height: 24),

                // 🔘 Enable (Switch)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loc.hotspotActiveLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colors.textPrimary,
                      ),
                    ),
                    Switch(
                      value: _enable,
                      activeThumbColor: colors.primary,
                      onChanged: (value) {
                        setState(() => _enable = value);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // ═══════════════════════════════════════════════════
                // BOUTON ENREGISTRER (apparaît si modifié)
                // ═══════════════════════════════════════════════════
                if (_hasChanges)
                  editState.when(
                    data: (_) => AppButton(
                      label: loc.saveChangesButton,
                      onPressed: () => _onSave(loc),
                      backgroundColor: colors.primary,
                    ),
                    loading: () => const AppLoader(),
                    error: (error, _) => Column(
                      children: [
                        Text(
                          error.toString(),
                          style: TextStyle(color: colors.error),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        AppButton(
                          label: loc.retry,
                          onPressed: () => _onSave(loc),
                          backgroundColor: colors.primary,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDisabledRow(String label, String value, AppColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colors.textSecondary,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: colors.textSecondary.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Future<void> _onSave(AppLocalizations loc) async {
    final controller = ref.read(editHotspotControllerProvider.notifier);

    await controller.editHotspot(
      hotspotId: widget.hotspotId,
      city: _cityController.text.trim(),
      enable: _enable,
    );

    final state = ref.read(editHotspotControllerProvider);

    state.whenOrNull(
      data: (_) {
        // ✅ 1. Vide le cache local
        ref.read(localSourceProvider).clearCache();

        // ✅ 2. Invalide la page de détail
        ref.invalidate(hotspotDetailControllerProvider(widget.hotspotId));

        // ✅ 3. Force le rechargement de la HomePage (sans utiliser le retour)
        ref.invalidate(homeControllerProvider);

        context.pop();
      },
    );
  }

}

// ═══════════════════════════════════════════════════════════
// WIDGET APPBAR PERSONNALISÉ
// ═══════════════════════════════════════════════════════════
class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppColors colors;
  final VoidCallback onBack;
  final IconData? icon;

  const _CustomAppBar({
    required this.title,
    required this.colors,
    required this.onBack,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colors.surface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colors.textPrimary),
        onPressed: onBack,
      ),
      title: icon != null
          ? Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      )
          : Text(
        title,
        style: TextStyle(
          color: colors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
