import 'dart:async';
import '../../domain/entities/hotspot_entity.dart';
import '../models/hotspot_model.dart';

class HotspotRemoteSource {
  /// Simule un appel API
  Future<List<HotspotModel>> fetchUserHotspots() async {
    await Future.delayed(const Duration(milliseconds: 900));
    return const [
      HotspotModel(
        id: '1',
        name: 'Houékégbo',
        wifiZone: 'Wifi Zone 1',
        dailySaleAmount: 50000,
        usersOnline: 10,
        role: HotspotRole.owner,
        isActive: true,
      ),
      HotspotModel(
        id: '2',
        name: 'Agla-Carrefour',
        wifiZone: 'Wifi Zone 2',
        dailySaleAmount: 10000,
        usersOnline: 6,
        role: HotspotRole.assistant,
        isActive: true,
      ),
      HotspotModel(
        id: '3',
        name: 'Godomey',
        wifiZone: 'Wifi Zone 3',
        dailySaleAmount: 50000,
        usersOnline: 10,
        role: HotspotRole.owner,
        isActive: false,
      ),
      HotspotModel(
        id: '4',
        name: 'Gbegamey',
        wifiZone: 'Wifi Zone 4',
        dailySaleAmount: 50000,
        usersOnline: 10,
        role: HotspotRole.owner,
        isActive: false,
      ),
    ];
  }
}
