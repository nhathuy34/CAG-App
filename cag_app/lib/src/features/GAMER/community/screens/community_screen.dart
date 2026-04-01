import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/features/GAMER/community/providers/community_provider.dart';
import 'package:CAG_App/src/features/GAMER/community/screens/dashcommunity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:CAG_App/src/features/GAMER/community/widgets/feed_tab/feed_tab_view.dart';
import 'package:CAG_App/src/features/GAMER/community/widgets/following_tab/following_tab_view.dart';
import 'package:CAG_App/src/features/GAMER/community/widgets/round_table_tab/roundtable_tab_view.dart';
import 'package:CAG_App/src/features/GAMER/community/widgets/find_teamate_tab/find_teammates_tab_view.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectIndex = ref.watch(communityTabIndexProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header Banner
            SliverToBoxAdapter(child: _buildBannerHeader()),

            // TabBar (Sticky nếu bạn bọc SliverPersistentHeader, hoặc thường)
            const CommuTabBar(),

            // NỘI DUNG CÁC TAB
            if (selectIndex == 0)
              const FeedTabView()
            else
              SliverToBoxAdapter(
                child: IndexedStack(
                  index: selectIndex,
                  children: const [
                    SizedBox(),
                    FollowingTabView(),
                    RoundtableTabView(),
                    FindTeammatesTabView(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerHeader() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4C1D95), Color(0xFF312E81)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF7E22CE).withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _animationPulseBadge("REVIEW TO EARN"),
          const Wrap(
            children: [
              Text(
                'BẠN CHƠI - BẠN REVIEW - ',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                'BẠN CÓ TIỀN',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Quy trình: Chơi game → Review → Kéo khách → Nhận hoa hồng trọn đời.',
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CagPrimaryButton(
                  text: 'Viết Review',
                  isGradient: true,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CagPrimaryButton(
                  text: 'Ví Của Tôi',
                  isBorder: true,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(child: _buildMonthlyIncomeCard()),
        ],
      ),
    );
  }

  Widget _buildMonthlyIncomeCard() {
    return Container(
      width: 230,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF251B61),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'THU NHẬP THÁNG NÀY',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '0 đ',
            style: TextStyle(
              color: Color(0xFF4AF89B),
              fontSize: 30,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF164E63),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Rút tiền ngay',
              style: TextStyle(
                color: Color(0xFF6EE7B7),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _animationPulseBadge(String content) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.5, end: 1.0).animate(_controller),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xFFEC4899),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFEC4899).withOpacity(0.4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
