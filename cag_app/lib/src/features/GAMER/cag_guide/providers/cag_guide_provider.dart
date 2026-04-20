import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/models/gamer_models.dart';
import 'package:CAG_App/src/repositories/cafe_repository.dart';

// Repository provider
final cafeRepositoryProvider = Provider<CafeRepository>((ref) {
  return CafeRepository();
});

// State providers for different cafe lists
final topTrendingCafesProvider = FutureProvider<List<Cafe>>((ref) async {
  final repository = ref.watch(cafeRepositoryProvider);
  return repository.getTopTrendingCafes();
});

final rtx40CafesProvider = FutureProvider<List<Cafe>>((ref) async {
  final repository = ref.watch(cafeRepositoryProvider);
  return repository.getRtx40Cafes();
});

final coupleZoneCafesProvider = FutureProvider<List<Cafe>>((ref) async {
  final repository = ref.watch(cafeRepositoryProvider);
  return repository.getCoupleZoneCafes();
});

final diamondCafesProvider = FutureProvider<List<Cafe>>((ref) async {
  final repository = ref.watch(cafeRepositoryProvider);
  return repository.getDiamondCafes();
});
