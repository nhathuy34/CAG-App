import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/features/GAMER/community/providers/community_provider.dart';
import 'package:CAG_App/src/features/GAMER/community/widgets/feed_tab/feed_tab_widgets.dart'; // Nơi chứa PostItemWidget

class FollowingTabView extends ConsumerWidget {
  const FollowingTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch cái kho chứa, hễ có bài mới là UI tự load lại
    final followingPosts = ref.watch(followingListProvider);

    // Nếu chưa bấm theo dõi ai
    if (followingPosts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 80),
        child: Center(
          child: Text(
            'Bạn chưa theo dõi ai.\nHãy quay lại bảng tin và theo dõi người chơi khác nhé!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 14, height: 1.5),
          ),
        ),
      );
    }

    // Nếu có data rồi thì duyệt mảng vẽ ra
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: followingPosts.map((post) {
          // Xài lại luôn cái PostItemWidget m đã code ở Bảng Tin
          return PostItemWidget(post: post); 
        }).toList(),
      ),
    );
  }
}