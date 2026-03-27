import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/community/providers/community_provider.dart';
import 'package:CAG_App/src/features/GAMER/community/screens/dashcommunity_widget.dart';
import 'package:CAG_App/src/features/GAMER/community/screens/feed_tab_view.dart';
import 'package:CAG_App/src/features/GAMER/community/screens/following_tab_view.dart';
import 'package:CAG_App/src/features/GAMER/community/screens/roundtable_tab_view.dart';
import 'package:CAG_App/src/features/GAMER/community/screens/find_teammates_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    // Tạo hiệu ứng lặp đi lặp lại (animate-pulse)
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
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Color(0xFF2E1065), Color(0xFF1E1B4B)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF8B5CF6).withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          animationPulse("REVIEW TO EARN"),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'BẠN CHƠI - BẠN REVIEW\n',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: AppTheme.textWhite,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                TextSpan(
                                  text: 'BẠN CÓ TIỀN',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: AppTheme.cyanNeon,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                    shadows: [
                                      Shadow(color: AppTheme.cyanNeon.withOpacity(0.5), blurRadius: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                color: AppTheme.textDim,
                                fontSize: 13,
                                height: 1.5,
                              ),
                              children: [
                                const TextSpan(text: 'Quy trình kiếm tiền:\n'),
                                const TextSpan(text: '1. Chơi game → 2. Viết Review\n3. Trở thành Đối Tác → 4. '),
                                TextSpan(
                                  text: 'Hoa hồng trọn đời.',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _buildActionButton(Icons.edit, 'Viết Review', const Color(0xFF4F46E5)),
                              const SizedBox(width: 8),
                              _buildActionButton(Icons.account_balance_wallet, 'Ví Của Tôi', Colors.white10, isBorder: true),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 4,
                      child: _buildEarningsCard(0),
                    ),
                  ],
                ),
              ),
            ),
            const CommuTabBar(),

            SliverFillRemaining(
              child: IndexedStack(
                index: selectIndex,
                children: [
                   const FeedTabView(),
                   const FollowingTabView(),
                   const RoundtableTabView(),
                   const FindTeammatesTabView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget animationPulse(String content) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.5, end: 1).animate(_controller),
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Color(0xFFEC4899),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFEC4899).withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          content,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color bgColor, {bool isBorder = false}) {
    return Expanded(
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: isBorder ? Border.all(color: Colors.white24) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsCard(int earnings) {
    final String formattedEarnings = earnings.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'THU NHẬP\nTHÁNG NÀY',
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          FittedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  formattedEarnings,
                  style: const TextStyle(
                    color: Color(0xFF4ADE80),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  '₫',
                  style: TextStyle(
                    color: Color(0xFF2DD4BF),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF134E4A),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Rút tiền ngay',
              style: TextStyle(
                color: Color(0xFF2DD4BF),
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
