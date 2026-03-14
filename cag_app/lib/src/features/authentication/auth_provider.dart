import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cag_app/src/utils/storage_helper.dart';

final authCheckerProvider = FutureProvider<String?>((ref) async {
  await Future.delayed(const Duration(seconds: 2)); // Delay để hiện slash screen

  final token = await StorageHelper.getToken();
  if(token != null && token.isNotEmpty) {
    return await StorageHelper.getRole();
  }
  return null; // không tìm thất token
});