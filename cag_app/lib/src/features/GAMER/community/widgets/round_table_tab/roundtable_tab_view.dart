import 'package:flutter/material.dart';
import 'roundtable_tab_widget.dart';

class RoundtableTabView extends StatelessWidget {
  const RoundtableTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DiscussionInputWidget(),
          const SizedBox(height: 20),
          const CategoryFiltersWidget(),
          const SizedBox(height: 20),
          DiscussionThreadWidget(
            userName: 'Gamer Ẩn Danh',
            timestamp: '5 giờ trước',
            isFollowing: false,
            upvotes: 3,
            title: 'LỖI SAVE GAME WUKONG KHÔNG LOAD ĐƯỢC Ở CHAPTER 4, AI BIẾT FIX KHÔNG CỨU VỚI :((',
            hashtags: ['#LoiGame', '#Help'],
            comments: 10,
          ),
        ],
      ),
    );
  }
}
