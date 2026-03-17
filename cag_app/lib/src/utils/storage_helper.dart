import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static const String _keyToken = 'token';
  static const String _keyRole = 'role';

  static Future<void> saveAuthData({
    required String token,
    required String role,
  }) async {
    await Future.wait([
      _storage.write(key: _keyToken, value: token),
      _storage.write(key: _keyRole, value: role),
    ]);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future<String?> getRole() async {
    return await _storage.read(key: _keyRole);
  }

  static Future<void> clearAuthData() async {
    await Future.wait([
      _storage.deleteAll(),
    ]);
  }
}