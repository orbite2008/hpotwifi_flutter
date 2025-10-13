import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/widgets/auth_app_bar.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/home_controller.dart';
import '../widgets/hotspot_list_view.dart';
import '../widgets/user_greeting_section.dart';
import 'home_loading_view.dart';
import 'home_error_view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final loc = AppLocalizations.of(context)!;

    final hotspotsState = ref.watch(homeControllerProvider);
    final query = ref.watch(hotspotSearchQueryProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: const AuthAppBar(
          title: "HpotWifi",
          showReportButton: true,
          showTicketButton: true,
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserGreetingSection(
              userName: 'Tynisha',
              searchController: _search,
              onChanged:
                  (value) =>
                      ref.read(hotspotSearchQueryProvider.notifier).state =
                          value,
            ),
            const SizedBox(height: 16),

            // 🔹 Titre + badge compteur
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: hotspotsState.when(
                loading: () => _buildHeaderSkeleton(colors, loc),
                error: (_, __) => _buildHeader(loc, colors, 0, 0),
                data: (list) {
                  final total = list.length;
                  final active = list.where((h) => h.isActive).length;
                  return _buildHeader(loc, colors, active, total);
                },
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Liste des hotspots
            Expanded(
              child: hotspotsState.when(
                loading: () => const HomeLoadingView(),
                error:
                    (e, _) => HomeErrorView(
                      message: e.toString(),
                      onRetry:
                          () =>
                              ref
                                  .read(homeControllerProvider.notifier)
                                  .refresh(),
                    ),
                data: (list) {
                  final q = query.toLowerCase().trim();
                  final filtered =
                      q.isEmpty
                          ? list
                          : list
                              .where(
                                (h) =>
                                    h.name.toLowerCase().contains(q) ||
                                    h.wifiZone.toLowerCase().contains(q),
                              )
                              .toList();

                  final adjusted =
                      filtered.map((h) {
                        if (!h.isActive && h.usersOnline > 0) {
                          return h.copyWith(usersOnline: 0);
                        }
                        return h;
                      }).toList();
                  return HotspotListView(
                    hotspots: adjusted,
                    onTapHotspot: (h) {
                      context.pushNamed('hotspotDetail', extra: h);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    AppLocalizations loc,
    AppColors colors,
    int active,
    int total,
  ) {
    return Row(
      children: [
        Text(
          loc.myHotspots,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: colors.textSecondary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${active.toString().padLeft(2, '0')}/${total.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSkeleton(AppColors colors, AppLocalizations loc) {
    return Row(
      children: [
        Text(
          loc.myHotspots,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 40,
          height: 18,
          decoration: BoxDecoration(
            color: colors.textSecondary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }
}
