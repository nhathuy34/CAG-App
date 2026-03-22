import 'dart:convert';

import 'package:CAG_App/src/models/gamer_stats.dart';
import 'package:CAG_App/src/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  // Sử dụng FlutterSecureStorage để lưu trữ an toàn token và role
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const String _keyToken = 'jwt_token';
  static const String _keyRole = 'role';
  static const String _keyUserData = 'user_data_profile';
  // // Keys cho Profile
  static const String _keyTrustScore = 'trust_score';
  static const String _keyHoursPlayed = 'hours_played';
  static const String _keyWinRate = 'win_rate';
  static const String _keyBalance = 'balance';
  static const String _keyAccessId = 'access_id';
  static const String _keyCards = 'linked_cards';
  static const String _keyLootbox = 'loot_Boxes';

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
    await Future.wait([_storage.deleteAll()]);
  }

  // Hàm tiện ích để kiểm tra xem người dùng đã đăng nhập hay chưa
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Lưu toàn bộ stats
  static Future<void> saveAllStats(GamerStats stats) async {
    await Future.wait([
      _storage.write(key: _keyBalance, value: stats.balance),
      _storage.write(key: _keyTrustScore, value: stats.trustScore),
      _storage.write(key: _keyHoursPlayed, value: stats.hoursPlayed),
      _storage.write(key: _keyWinRate, value: stats.winRate),
      _storage.write(key: _keyAccessId, value: stats.accessId),
      _storage.write(
        key: _keyCards,
        value: jsonEncode(stats.linkedCards.map((e) => e.toJson()).toList()),
      ),
      _storage.write(
        key: _keyLootbox,
        value: jsonEncode(stats.lootBoxes.map((e) => e.toJson()).toList()),
      ),
    ]);
  }

  // Đọc toàn bộ dữ liệu hiện có
  static Future<GamerStats> loadAllStats() async {
    final all = await _storage.readAll();
    final cardsJson = all[_keyCards];
    final lootboxJson = all[_keyLootbox];
    List<MembershipCard> cards = [];
    List<LootBoxItem> items = [];
    if (cardsJson != null) {
      cards = (jsonDecode(cardsJson) as List)
          .map((e) => MembershipCard.fromJson(e))
          .toList();
    }
    if (lootboxJson != null) {
      items = (jsonDecode(lootboxJson) as List)
          .map((e) => LootBoxItem.fromJson(e))
          .toList();
    }

    return GamerStats(
      balance: all[_keyBalance] ?? '2.500.000',
      trustScore: all[_keyTrustScore] ?? '100',
      hoursPlayed: all[_keyHoursPlayed] ?? '1,240',
      winRate: all[_keyWinRate] ?? '54',
      accessId: all[_keyAccessId] ?? '000001',
      linkedCards: cards,
      lootBoxes: items,
    );
  }

  // Hàm đọc/ghi chuỗi cơ bản cho Provider gọi
  static Future<String?> loadString(String key) async {
    return await _storage.read(key: key);
  }
  static Future<void> saveString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Hàm lưu thông tin profile
  static Future<void> saveUserProfile(Usermodel user) async {
    await _storage.write(key: _keyUserData, value: jsonEncode(user.toJson()));
  }

  // Hàm load thông tin profile
  static Future<Usermodel?> loadUserProfile() async{
    final jsonString=await _storage.read(key: _keyUserData);
    if(jsonString !=null){
      return Usermodel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }
}
