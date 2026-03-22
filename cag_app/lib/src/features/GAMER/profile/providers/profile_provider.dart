import 'package:CAG_App/src/models/gamer_stats.dart';
import 'package:CAG_App/src/models/user_model.dart';
import 'package:CAG_App/src/repositories/gamer_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Khởi tạo Repository Provider dùng chung
final gamerRepositoryProvider = Provider<GamerRepository>(
  (ref) => GamerRepository(),
);

// Quản lý Tab Index
final profileTabIndexProvider = StateProvider<int>((ref) => 0);

// Quản lý Stats
final userStatsProvider =
    StateNotifierProvider<UserStatsNotifier, AsyncValue<GamerStats>>((ref) {
      return UserStatsNotifier(ref.watch(gamerRepositoryProvider));
    });

class UserStatsNotifier extends StateNotifier<AsyncValue<GamerStats>> {
  final GamerRepository _repository;

  UserStatsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadStats();
  }

  Future<void> loadStats() async {
    try {
      state = const AsyncValue.loading();
      final stats = await _repository.fetchUserStats();
      state = AsyncValue.data(stats);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// Quản lý Profile
final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, AsyncValue<Usermodel>>((ref) {
      return UserProfileNotifier(ref.watch(gamerRepositoryProvider));
    });

class UserProfileNotifier extends StateNotifier<AsyncValue<Usermodel>> {
  final GamerRepository _repository;

  UserProfileNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      state = const AsyncValue.loading();
      final user = await _repository.fetchUserProfile();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // Hàm update profile từ UI gọi xuống
  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    if (state is AsyncData) {
      final currentUser = state.value!;
      final updatedUser = currentUser.copyWith(
        fullName: name,
        phoneNumber: phone,
      );
      await _repository.updateUserProfile(updatedUser);
      state = AsyncValue.data(updatedUser);
    }
  }
}
