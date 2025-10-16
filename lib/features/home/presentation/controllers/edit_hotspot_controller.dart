// lib/features/home/presentation/controllers/edit_hotspot_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/providers/global_providers.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../domain/usecases/edit_hotspot_usecase.dart';

final editHotspotControllerProvider =
StateNotifierProvider<EditHotspotController, AsyncValue<void>>((ref) {
  final useCase = ref.read(editHotspotUseCaseProvider);
  return EditHotspotController(useCase);
});

class EditHotspotController extends StateNotifier<AsyncValue<void>> {
  final EditHotspotUseCase _editHotspotUseCase;

  EditHotspotController(this._editHotspotUseCase)
      : super(const AsyncValue.data(null));

  Future<void> editHotspot({
    required int hotspotId,
    required String city,
    required bool enable,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _editHotspotUseCase(
        hotspotId: hotspotId,
        city: city,
        enable: enable,
      );
    });
  }
}
