// lib/features/home/presentation/controllers/hotspot_detail_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/providers/global_providers.dart';
import '../../domain/entities/hotspot_entity.dart';
import '../../domain/usecases/get_hotspot_by_id_usecase.dart';
import '../../data/sources/hotspot_local_source.dart';
import '../../data/sources/hotspot_remote_source.dart';
import '../../data/repositories/hotspot_repository.dart';

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

final _getHotspotByIdProvider = Provider(
      (ref) => GetHotspotByIdUseCase(ref.read(_repositoryProvider)),
);


final hotspotDetailControllerProvider = FutureProvider.family<HotspotEntity, int>(
      (ref, hotspotId) async {
    final usecase = ref.read(_getHotspotByIdProvider);
    return usecase(hotspotId);
  },
);
