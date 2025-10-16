import '../entities/hotspot_entity.dart';
import '../../data/repositories/hotspot_repository.dart';

class GetUserHotspotsUseCase {
  GetUserHotspotsUseCase(this._repo);
  final HotspotRepository _repo;

  Future<List<HotspotEntity>> call() => _repo.getUserHotspots();
}
