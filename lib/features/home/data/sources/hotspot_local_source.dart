import '../models/hotspot_model.dart';

class HotspotLocalSource {
  List<HotspotModel>? _cache;

  List<HotspotModel>? readCache() => _cache;

  void writeCache(List<HotspotModel> data) {
    _cache = data;
  }
}
