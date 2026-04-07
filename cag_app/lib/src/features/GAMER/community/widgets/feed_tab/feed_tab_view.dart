import 'package:CAG_App/src/features/GAMER/community/providers/community_provider.dart';
import 'package:CAG_App/src/features/GAMER/community/widgets/feed_tab/feed_tab_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedTabView extends ConsumerWidget {
  const FeedTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questsAsync = ref.watch(questFutureProvider);
    final feedAsync = ref.watch(feedStreamProvider);

    return SliverList(
      delegate: SliverChildListDelegate([
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SectionHeaderWithPulse(title: 'NHIỆM VỤ CHỦ QUÁN (SĂN THƯỞNG)'),
        ),
        const SizedBox(height: 12),
        
        // 1. List ngang Nhiệm vụ
        SizedBox(
          height: 95,
          child: questsAsync.when(
            data: (quests) => ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16),
              itemCount: quests.length,
              itemBuilder: (context, index) => QuestCard(quest: quests[index]),
            ),
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),
        ),
        
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16), 
          child: PostInputWidget()
        ),
        const SizedBox(height: 16),

        // 2. Danh sách bài viết
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: feedAsync.when(
            data: (posts) => Column(
              children: posts.map((post) => PostItemWidget(post: post)).toList(),
            ),
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(color: Colors.cyan),
              ),
            ),
            error: (_, __) => const SizedBox(),
          ),
        ),
        const SizedBox(height: 100),
      ]),
    );
  }
}

class SectionHeaderWithPulse extends StatefulWidget {
  final String title;
  const SectionHeaderWithPulse({super.key, required this.title});

  @override
  State<SectionHeaderWithPulse> createState() => _SectionHeaderWithPulseState();
}

class _SectionHeaderWithPulseState extends State<SectionHeaderWithPulse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FadeTransition(
          opacity: _controller,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFFEAB308),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          widget.title,
          style: const TextStyle(
            color: Color(0xFFEAB308),
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}