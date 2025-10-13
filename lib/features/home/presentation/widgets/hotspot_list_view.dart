import 'package:flutter/material.dart';
import '../../domain/entities/hotspot_entity.dart';
import 'hotspot_card.dart';

class HotspotListView extends StatelessWidget {
  const HotspotListView({
    super.key,
    required this.hotspots,
    required this.onTapHotspot,
  });

  final List<HotspotEntity> hotspots;
  final void Function(HotspotEntity) onTapHotspot;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: hotspots.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final h = hotspots[index];
        return HotspotCard(hotspot: h, onTap: () => onTapHotspot(h));
      },
    );
  }
}

