// lib/features/home/data/sources/hotspot_local_source.dart

import '../models/hotspot_model.dart';

class HotspotLocalSource {
  List<HotspotModel>? _cache;

  /// Lit le cache en mémoire
  List<HotspotModel>? readCache() => _cache;

  /// Écrit dans le cache en mémoire
  void writeCache(List<HotspotModel>? data) {
    _cache = data;
  }

  /// ✅ NOUVEAU : Vide le cache
  void clearCache() {
    _cache = null;
  }
}
