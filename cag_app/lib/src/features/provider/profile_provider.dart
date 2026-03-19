import 'package:CAG_App/src/models/gamerStats.dart';
import 'package:CAG_App/src/utils/storage_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final profileTabIndexProvider = StateProvider<int>((ref) => 0);

final userStatsProvider =
    StateNotifierProvider<UserStatsNotifier, AsyncValue<GamerStats>>((ref) {
      return UserStatsNotifier();
    });

class UserStatsNotifier extends StateNotifier<AsyncValue<GamerStats>> {
  UserStatsNotifier() : super(const AsyncValue.loading()) {
    loadStats();
  }

  // Hàm đọc dữ liệu từ StorageHelper
  Future<void> loadStats() async {
    try {
      final stats = await StorageHelper.loadAllStats();
      // Nếu app mới chưa có card, ta thêm mock data
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
        state = AsyncValue.data(initialStats);
      } else {
        state = AsyncValue.data(stats);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Future<void> updateBalance(String newBalance) async {
  //   if (state.hasValue) {
  //     final updated = GamerStats(
  //       trustScore: state.value!.trustScore,
  //       hoursPlayed: state.value!.hoursPlayed,
  //       winRate: state.value!.winRate,
  //       balance: newBalance,
  //       accessId: state.value!.accessId,
  //       linkedCards: state.value!.linkedCards,
  //     );
  //     await StorageHelper.saveAllStats(updated);
  //     state = AsyncValue.data(updated);
  //   }
  // }
}
