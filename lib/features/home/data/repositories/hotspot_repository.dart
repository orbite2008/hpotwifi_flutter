// lib/features/home/data/repositories/hotspot_repository.dart

import '../../domain/entities/hotspot_entity.dart';
import '../models/hotspot_model.dart';
import '../sources/hotspot_local_source.dart';
import '../sources/hotspot_remote_source.dart';

class HotspotRepository {
  HotspotRepository(this._remote, this._local);

  final HotspotRemoteSource _remote;
  final HotspotLocalSource _local;

  /// Récupère les hotspots (utilise le cache si disponible)
  Future<List<HotspotEntity>> getUserHotspots() async {
    final cached = _local.readCache();
    if (cached != null) {
      return cached.map((m) => m.toEntity()).toList();
    }

    final remote = await _remote.fetchUserHotspots();
    _local.writeCache(remote);
    return remote.map((m) => m.toEntity()).toList();
  }

  /// Force le rafraîchissement depuis l'API (ignore le cache)
  Future<List<HotspotEntity>> refreshHotspots() async {
    final remote = await _remote.fetchUserHotspots();
    _local.writeCache(remote);
    return remote.map((m) => m.toEntity()).toList();
  }

  /// Crée un nouveau hotspot
  Future<HotspotEntity> createHotspot({
    required String hotspotwifiname,
    required String hotspotzonename,
    required String city,
    required String neighborhood,
  }) async {
    final model = await _remote.createHotspot(
      hotspotwifiname: hotspotwifiname,
      hotspotzonename: hotspotzonename,
      city: city,
      neighborhood: neighborhood,
    );

    _local.clearCache(); // Vide le cache
    return model.toEntity();
  }

  /// Récupère les détails d'un hotspot par son ID
  Future<HotspotEntity> getHotspotById(int id) async {
    // Appel API direct (pas de cache pour les détails)
    final model = await _remote.fetchHotspotById(id);
    return model.toEntity();
  }

  /// ✅ NOUVEAU : Édite un hotspot existant
  Future<void> editHotspot({
    required int hotspotId,
    required String city,
    required bool enable,
  }) async {
    await _remote.editHotspot(
      hotspotId: hotspotId,
      city: city,
      enable: enable,
    );

    // ✅ Invalide le cache pour forcer un refresh
    _local.clearCache();
  }
}
