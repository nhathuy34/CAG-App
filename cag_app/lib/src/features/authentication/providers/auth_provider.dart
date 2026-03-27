import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/utils/storage_helper.dart';
import 'package:flutter_riverpod/legacy.dart';

// Provider để quản lý Role (Gamer hay Owner)
final isGamerProvider = StateProvider<bool>((ref) => true);

// Quản lý chiều cao của Form hiện tại
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
  "Phường Ba Đình", "Quận Cầu Giấy", "Quận Đống Đa"
]);
final selectedDistrictProvider = StateProvider<String>((ref) {
  return ref.watch(districtListProvider).first;
});

// FutureProvider để kiểm tra token và lấy role khi app khởi động
final authCheckerProvider = FutureProvider<String?>((ref) async {
  ref.keepAlive(); // Giữ provider này sống để tránh bị reload bất ngờ
  
  try {
    await Future.delayed(const Duration(seconds: 3)); // Tăng thời gian delay một chút

    final bool loggedIn = await StorageHelper.isLoggedIn();
    if (loggedIn) {
      final role = await StorageHelper.getRole();
      return role;
    }
  } catch (e) {
    // Nếu có lỗi khi đọc storage, trả về null để về màn Welcome
    return null;
  }
  return null;
});