import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  // Sử dụng FlutterSecureStorage để lưu trữ an toàn token và role
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static const String _keyToken = 'jwt_token';
  static const String _keyRole = 'role';

  // Hàm lưu token và role sau khi đăng nhập thành công
  static Future<void> saveAuthData({
    required String token,
    required String role,
  }) async {
    await Future.wait([
      _storage.write(key: _keyToken, value: token),
      _storage.write(key: _keyRole, value: role),
    ]);
  }

  // Hàm lấy token JWT
  static Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  // Hàm lấy role của người dùng
  static Future<String?> getRole() async {
    return await _storage.read(key: _keyRole);
  }

  // Hàm xóa dữ liệu đăng nhập khi người dùng đăng xuất
  static Future<void> clearAuthData() async {
    await Future.wait([
      _storage.deleteAll(),
    ]);
  }

  // Hàm tiện ích để kiểm tra xem người dùng đã đăng nhập hay chưa
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}