import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../repositories/zone_repository.dart';
import '../../../../models/zone_model.dart';

final zoneRepositoryProvider = Provider<ZoneRepository>((ref) => ZoneRepository());

final zonesProvider = FutureProvider<List<ZoneModel>>((ref) async {
  return ref.watch(zoneRepositoryProvider).fetchZones();
});

final utilitiesProvider = FutureProvider<List<UtilityModel>>((ref) async {
  return ref.watch(zoneRepositoryProvider).fetchUtilities();
});