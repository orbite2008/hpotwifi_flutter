// lib/features/home/presentation/widgets/hotspot_list_view.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/hotspot_entity.dart';
import 'hotspot_card.dart';
import 'empty_hotspots_view.dart';
import 'no_search_results_view.dart';

class HotspotListView extends StatelessWidget {
  const HotspotListView({
    super.key,
    required this.hotspots,
    this.searchQuery,
  });

  final List<HotspotEntity> hotspots;
  final String? searchQuery;

  @override
  Widget build(BuildContext context) {
    if (hotspots.isEmpty) {
      if (searchQuery != null && searchQuery!.isNotEmpty) {
        return NoSearchResultsView(searchQuery: searchQuery!);
      }

      return const EmptyHotspotsView();
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: hotspots.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final h = hotspots[index];

        return HotspotCard(
          hotspot: h,
          onTap: () {
            context.pushNamed(
              'hotspotDetail',
              pathParameters: {'id': h.id.toString()},
            );
          },
        );
      },
    );
  }
}
