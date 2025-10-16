// lib/features/home/domain/usecases/create_hotspot_usecase.dart

import '../entities/hotspot_entity.dart';
import '../../data/repositories/hotspot_repository.dart';

class CreateHotspotUseCase {
  final HotspotRepository _repository;

  CreateHotspotUseCase(this._repository);

  /// Crée un nouveau hotspot
  Future<HotspotEntity> call({
    required String hotspotwifiname,
    required String hotspotzonename,
    required String city,
    required String neighborhood,
  }) async {
    return _repository.createHotspot(
      hotspotwifiname: hotspotwifiname,
      hotspotzonename: hotspotzonename,
      city: city,
      neighborhood: neighborhood,
    );
  }
}
