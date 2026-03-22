import 'package:CAG_App/src/models/gamer_stats.dart';
import 'package:CAG_App/src/models/user_model.dart';
import 'package:CAG_App/src/utils/storage_helper.dart';

class GamerRepository {
  // --- XỬ LÝ GAMER STATS ---
  Future<GamerStats> fetchUserStats() async {
    try {
      // Giả lập delay mạng
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

  // --- XỬ LÝ USER PROFILE ---
  Future<Usermodel> fetchUserProfile() async {
    final user = await StorageHelper.loadUserProfile();
    if (user != null) return user;

    return Usermodel(
      userType: 1,
      fullName: "Lương Quang Vinh",
      phoneNumber: "0987654321",
      email: "vinh@cag.vn",
      username: "luongvinh",
      password: "",
      province: "",
      commune: "",
      district: "",
    );
  }

  Future<void> updateUserProfile(Usermodel user) async {
    await StorageHelper.saveUserProfile(user);
  }
}
