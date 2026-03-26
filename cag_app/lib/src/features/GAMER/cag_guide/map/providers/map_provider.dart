import 'package:CAG_App/src/models/map_location.dart';
import 'package:CAG_App/src/repositories/map_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

// Provider cung cấp Repository
final mapRepoProvider = Provider<MapRepository>((ref) => MapRepository());

// Provider quản lý GPS User
final userLocationProvider = FutureProvider<Position>((ref) async {
  return ref.read(mapRepoProvider).getCurrentLocation();
});

// Provider quản lý danh sách Quán Net (Phụ thuộc vào userLocationProvider)
final nearbyCafesProvider = FutureProvider<List<MapLocation>>((ref) async {
  // Chờ lấy GPS xong mới gọi API
  final userLoc = await ref.watch(userLocationProvider.future);
  return ref.read(mapRepoProvider).getNearbyCyberCafes(userLoc.latitude, userLoc.longitude);
});