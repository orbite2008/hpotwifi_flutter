// lib/features/home/domain/usecases/edit_hotspot_usecase.dart

import '../../data/repositories/hotspot_repository.dart';

class EditHotspotUseCase {
  final HotspotRepository repository;

  EditHotspotUseCase(this.repository);

  Future<void> call({
    required int hotspotId,
    required String city,
    required bool enable,
  }) {
    return repository.editHotspot(
      hotspotId: hotspotId,
      city: city,
      enable: enable,
    );
  }
}
