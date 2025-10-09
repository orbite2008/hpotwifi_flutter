import '../../domain/entities/hotspot_entity.dart';
import '../models/hotspot_model.dart';
import '../sources/hotspot_local_source.dart';
import '../sources/hotspot_remote_source.dart';

class HotspotRepository {
  HotspotRepository(this._remote, this._local);
  final HotspotRemoteSource _remote;
  final HotspotLocalSource _local;

  Future<List<HotspotEntity>> getUserHotspots() async {
    // essaie le cache
    final cached = _local.readCache();
    if (cached != null) {
      return cached.map((m) => m.toEntity()).toList();
    }

    // fetch remote
    final remote = await _remote.fetchUserHotspots();
    _local.writeCache(remote);
    return remote.map((m) => m.toEntity()).toList();
  }
}
