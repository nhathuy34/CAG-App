import 'package:CAG_App/src/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/utils/storage_helper.dart';
import 'package:flutter_riverpod/legacy.dart';

// Provider để quản lý Role (Gamer hay Owner)
final isGamerProvider = StateProvider<bool>((ref) => true);

// Quản lý chiều cao của Form hiện tại để tự động resize khung chứa
final authFormHeightProvider = StateProvider<double>((ref) => 330);

// Danh sách tỉnh thành
final provinceListProvider = Provider<List<String>>((ref) => [
  "Thành phố Hà Nội", "TP. Hồ Chí Minh", "TP. Đà Nẵng", "Cần Thơ"
]);
final selectedProvinceProvider = StateProvider<String>((ref) {
  return ref.watch(provinceListProvider).first;
});

// Tương tự cho Quận/Huyện
final districtListProvider = Provider<List<String>>((ref) => [
  "Phường Ba Đình", "Quận Cầu Giấy", "Quận Đống Đa", "Quận 1", "Quận 10"
]);
final selectedDistrictProvider = StateProvider<String>((ref) {
  return ref.watch(districtListProvider).first;
});

// FutureProvider để kiểm tra token và lấy role khi app khởi động
final authCheckerProvider = FutureProvider<String?>((ref) async {
  // await Future.delayed(const Duration(seconds: 2)); // T khuyên nên bỏ cái delay này đi cho nhanh
  final bool loggedIn = await StorageHelper.isLoggedIn();
  if (loggedIn) {
    final role = await StorageHelper.getRole();
    return role ?? 'GAMER';
  }
  return null;
});

// Khai báo cái này ở file chứa các Provider của m
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authStateProvider = StateProvider<String?>((ref) {
  // .maybeWhen này giúp lấy giá trị nếu đã có, còn chưa có (đang load) thì để null
  // Nó chỉ chạy 1 lần duy nhất lúc khởi tạo Provider này
  return ref.watch(authCheckerProvider).maybeWhen(
        data: (role) => role,
        orElse: () => null,
      );
});