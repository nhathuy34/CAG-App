import 'package:CAG_App/src/models/gamer_models.dart';
import 'package:CAG_App/src/repositories/community_repositories..dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final communityTabIndexProvider = StateProvider<int>((ref)=>0);

final communityRepoProvider = Provider((ref) => CommunityRepository());

final feedStreamProvider = StreamProvider<List<PostModel>>((ref) {
  return ref.watch(communityRepoProvider).getFeedStream();
});

final questFutureProvider = FutureProvider<List<QuestModel>>((ref) {
  return ref.watch(communityRepoProvider).fetchQuests();
});

class FollowingListNotifier extends StateNotifier<List<PostModel>> {
  FollowingListNotifier() : super([]);

  // Hàm thêm bài viết vào danh sách
  void addPost(PostModel post) {
 
    bool isExist = state.any((p) => p.author.fullName == post.author.fullName);
    
    if (!isExist) {

      state = [...state, post];
    }
  }

  // Hàm bỏ theo dõi (Tùy chọn cho m xài sau)
  void removePost(String authorName) {
    state = state.where((p) => p.author.fullName != authorName).toList();
  }
}

// 2. Khai báo Provider để gọi ở các file khác
final followingListProvider = StateNotifierProvider<FollowingListNotifier, List<PostModel>>((ref) {
  return FollowingListNotifier();
});
