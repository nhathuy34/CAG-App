import 'package:CAG_App/src/models/gamer_models.dart';
import 'package:CAG_App/src/utils/storage_helper.dart';
import 'package:CAG_App/src/features/GAMER/profile/service/profile_api.dart'; 

class GamerRepository {
  // Khai báo file gọi API Profile
  final ProfileApi _profileApi = ProfileApi();

  // ==========================================
  // --- 1. XỬ LÝ GAMER STATS (GIỮ NGUYÊN) ---
  // ==========================================
  Future<GamerStats> fetchUserStats() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final stats = await StorageHelper.loadAllStats();

      // Khởi tạo Mock Data nếu chưa có
      if (stats.linkedCards.isEmpty || stats.lootBoxes.isEmpty) {
        final initialStats = GamerStats(
          trustScore: '100',
          hoursPlayed: '1,240',
          winRate: '54',
          balance: '2.500.000',
          accessId: '000001',
          linkedCards: [
            MembershipCard(
              title: 'FLASH GAMING CENTER',
              number: '4829  1023  4512  9981',
              price: '152,000',
              memberType: 'DIAMOND MEMBER',
              imagePath: 'https://picsum.photos/100/100?random=101',
              isOnline: true,
            ),
            MembershipCard(
              title: 'GAMING HOUSE PRO',
              number: '4001  2231  5566  1122',
              price: '85,000',
              memberType: 'GOLD MEMBER',
              imagePath: 'https://picsum.photos/100/100?random=103',
              isOnline: false,
            ),
            MembershipCard(
              title: 'SPEED GAMING 2',
              number: '5123 8812 3321 0021',
              price: '12,000',
              memberType: 'SILVER MEMBER',
              imagePath: 'https://picsum.photos/100/100?random=102',
              isOnline: false,
            ),
          ],
          lootBoxes: [
            LootBoxItem(
              id: '1',
              tag: 'FOOD',
              title: 'MÌ TRỨNG XÚC XÍCH',
              price: '300 P',
              imagePath: 'https://picsum.photos/seed/food1/300/400',
            ),
            LootBoxItem(
              id: '2',
              tag: 'HOURS',
              title: 'THẺ 1 GIỜ CHƠI (VIP)',
              price: '800 P',
              imagePath: 'https://picsum.photos/seed/hours/300/400',
            ),
            LootBoxItem(
              id: '3',
              tag: 'FOOD',
              title: 'NƯỚC ÉP CAM',
              price: '150 P',
              imagePath: 'https://picsum.photos/seed/juice/300/400',
            ),
          ],
        );
        await StorageHelper.saveAllStats(initialStats);
        return initialStats;
      }
      return stats;
    } catch (e) {
      throw Exception('Lỗi khi tải dữ liệu Gamer: $e');
    }
  }

  Future<void> updateUserStats(GamerStats stats) async {
    await StorageHelper.saveAllStats(stats);
  }

 // gamer_repository.dart

  // gamer_repository.dart

  Future<Usermodel> fetchUserProfile() async {
  final cachedUser = await StorageHelper.loadUserProfile();
  final cachedAvatarUrl = await StorageHelper.loadLastAvatarUrl(); // ← lấy avatar riêng

  try {
    final bool loggedIn = await StorageHelper.isLoggedIn();
    if (loggedIn) {
      final userFromServer = await _profileApi.getMe();
      if (userFromServer != null) {
        final resolvedAvatar =
            (userFromServer.avatarUrl == null || userFromServer.avatarUrl!.isEmpty)
                ? cachedAvatarUrl // ← dùng key riêng thay vì cachedUser
                : userFromServer.avatarUrl;

        final mergedUser = userFromServer.copyWith(avatarUrl: resolvedAvatar);
        await StorageHelper.saveUserProfile(mergedUser);
        return mergedUser;
      }
    }
  } catch (e) {
    print("Lỗi fetch profile: $e");
  }

  if (cachedUser != null && cachedUser.id != 0) return cachedUser;

  return Usermodel(
    id: 0,
    userType: 0,
    fullName: "GUEST OPERATOR",
    username: "GUST",
    phoneNumber: "Chưa đăng nhập",
    email: "", password: "", province: "", commune: "", district: "",
    avatarUrl: null, // ← guest không có cachedAvatarUrl nên vẫn null ✅
  );
}

    Future<Usermodel> updateUserProfile({
    required Usermodel currentUser,
    required String name,
    required String phone,
    String? localImagePath,
  }) async {
    String? newAvatarUrl = currentUser.avatarUrl;

    if (localImagePath != null && localImagePath.trim().isNotEmpty && !localImagePath.startsWith('http')) {
      final uploadedUrl = await _profileApi.uploadAvatar(localImagePath);
      if (uploadedUrl != null) {
        newAvatarUrl = uploadedUrl;
        await StorageHelper.saveLastAvatarUrl(uploadedUrl); // ← nằm trong cùng scope
      }
    }

    await _profileApi.updateProfile(name, phone, avatarUrl: newAvatarUrl);

    final updatedUser = currentUser.copyWith(
      fullName: name,
      phoneNumber: phone,
      avatarUrl: newAvatarUrl,
    );

    await StorageHelper.saveUserProfile(updatedUser);
    return updatedUser;
    }
}
