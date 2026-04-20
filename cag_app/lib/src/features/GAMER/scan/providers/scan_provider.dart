import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:CAG_App/src/models/gamer_models.dart';
import 'package:CAG_App/src/repositories/scan_repository.dart';

// Provider cho Repository
final scanRepositoryProvider = Provider<ScanRepository>((ref) {
  return ScanRepository();
});

// Provider quản lý trạng thái của quá trình quét
final scanProvider = StateNotifierProvider<ScanNotifier, AsyncValue<ScanData?>>((ref) {
  final repository = ref.watch(scanRepositoryProvider);
  return ScanNotifier(repository);
});

class ScanNotifier extends StateNotifier<AsyncValue<ScanData?>> {
  final ScanRepository _repository;

  ScanNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> processScannedCode(String code, {String? type}) async {
    state = const AsyncValue.loading();
    try {
      // Giả lập xử lý quét/kết nối backend hoặc giải mã QR code (debounce/delay)
      await Future.delayed(const Duration(milliseconds: 1500));

      final scanData = ScanData(
        code: code,
        scannedAt: DateTime.now(),
        type: type,
      );

      // Lưu trữ thông qua Repository (Secure Storage)
      await _repository.saveScanData(scanData);

      state = AsyncValue.data(scanData);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
