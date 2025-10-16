// lib/features/home/presentation/controllers/home_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/providers/global_providers.dart';
import '../../domain/entities/hotspot_entity.dart';
import '../../domain/usecases/get_user_hotspots_usecase.dart';
import '../../domain/usecases/create_hotspot_usecase.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/sources/hotspot_local_source.dart';
import '../../data/sources/hotspot_remote_source.dart';
import '../../data/repositories/hotspot_repository.dart';

// Provider pour la source remote avec injection ApiClient
final _remoteSourceProvider = Provider((ref) {
  final apiClient = ref.read(httpClientProvider);
  return HotspotRemoteSource(apiClient);
});

final _localSourceProvider = Provider((ref) => HotspotLocalSource());

final _repositoryProvider = Provider(
      (ref) => HotspotRepository(
    ref.read(_remoteSourceProvider),
    ref.read(_localSourceProvider),
  ),
);

final _getHotspotsProvider = Provider(
      (ref) => GetUserHotspotsUseCase(ref.read(_repositoryProvider)),
);

// ✅ NOUVEAU Provider pour créer un hotspot
final _createHotspotProvider = Provider(
      (ref) => CreateHotspotUseCase(ref.read(_repositoryProvider)),
);

final homeControllerProvider =
AsyncNotifierProvider<HomeController, List<HotspotEntity>>(
  HomeController.new,
);

class HomeController extends AsyncNotifier<List<HotspotEntity>> {
  @override
  Future<List<HotspotEntity>> build() async {
    final usecase = ref.read(_getHotspotsProvider);
    return usecase();
  }

  /// Ajoute temporairement un hotspot (pour preview avant API)
  void addTemporaryHotspot(HotspotEntity hotspot) {
    state.whenData((list) {
      final updatedList = [hotspot, ...list];
      state = AsyncData(updatedList);
    });
  }

  Future<HotspotEntity> createHotspot({
    required String hotspotwifiname,
    required String hotspotzonename,
    required String city,
    required String neighborhood,
  }) async {
    final usecase = ref.read(_createHotspotProvider);

    // Appel API
    final newHotspot = await usecase(
      hotspotwifiname: hotspotwifiname,
      hotspotzonename: hotspotzonename,
      city: city,
      neighborhood: neighborhood,
    );

    // Rafraîchit la liste automatiquement
    await refresh();

    return newHotspot;
  }

  /// Rafraîchit la liste depuis l'API
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(_repositoryProvider);
      return repository.refreshHotspots();
    });
  }
}

/// Recherche locale
final hotspotSearchQueryProvider = StateProvider<String>((ref) => "");
