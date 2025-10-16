// lib/features/home/domain/usecases/get_hotspot_by_id_usecase.dart

import '../entities/hotspot_entity.dart';
import '../../data/repositories/hotspot_repository.dart';

class GetHotspotByIdUseCase {
  final HotspotRepository _repository;

  GetHotspotByIdUseCase(this._repository);

  /// Récupère les détails d'un hotspot par son ID
  Future<HotspotEntity> call(int id) async {
    return _repository.getHotspotById(id);
  }
}
