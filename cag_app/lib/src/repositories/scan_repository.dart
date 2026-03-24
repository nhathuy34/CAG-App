import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:CAG_App/src/models/scan_data.dart';

class ScanRepository {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const String _scanHistoryKey = 'scan_history_gamers';

  Future<void> saveScanData(ScanData data) async {
    try {
      final List<ScanData> currentHistory = await getScanHistory();
      currentHistory.insert(0, data);

      // Lưu tối đa 20 lịch sử scan gần nhất
      final limitedHistory = currentHistory.take(20).toList();

      final String jsonString = jsonEncode(
        limitedHistory.map((e) => e.toJson()).toList(),
      );

      await _secureStorage.write(key: _scanHistoryKey, value: jsonString);
    } catch (e) {
      throw Exception('Lỗi khi lưu dữ liệu scan: $e');
    }
  }

  Future<List<ScanData>> getScanHistory() async {
    try {
      final String? jsonString = await _secureStorage.read(key: _scanHistoryKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((e) => ScanData.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> clearScanHistory() async {
    await _secureStorage.delete(key: _scanHistoryKey);
  }
}
