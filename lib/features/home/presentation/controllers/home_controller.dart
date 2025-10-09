import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/hotspot_entity.dart';
import '../../domain/usecases/get_user_hotspots_usecase.dart';
import '../../data/sources/hotspot_local_source.dart';
import '../../data/sources/hotspot_remote_source.dart';
import '../../data/repositories/hotspot_repository.dart';
import 'package:flutter_riverpod/legacy.dart';


final _remoteSourceProvider = Provider((ref) => HotspotRemoteSource());
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

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final usecase = ref.read(_getHotspotsProvider);
      return usecase();
    });
  }
}

/// Recherche locale
final hotspotSearchQueryProvider = StateProvider<String>((ref) => "");
