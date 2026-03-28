import 'package:CAG_App/src/models/post_model.dart';
import 'package:CAG_App/src/repositories/community_repository.dart';
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