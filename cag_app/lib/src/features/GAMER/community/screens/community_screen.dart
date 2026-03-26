import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/community/providers/community_provider.dart';
import 'package:CAG_App/src/features/GAMER/community/screens/dashcommunity_widget.dart';
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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF4C1D95), Color(0xFF312E81)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF7E22CE).withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    animationPulse("REVIEW TO EARN"),
                    Wrap(
                      children: [
                        Text(
                          'BẠN CHƠI - BẠN REVIEW - ',
                          style: TextStyle(
                            fontSize: 28,
                            color: AppTheme.textWhite,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            letterSpacing: -1,
                          ),
                        ),
                        Text(
                          'BẠN CÓ TIỀN',
                          style: TextStyle(
                            fontSize: 28,
                            color: AppTheme.cyanNeon,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          color: AppTheme.textDim,
                          fontSize: 14,
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Quy trình kiếm tiền:\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text:
                                '1. Chơi game → 2. Review → 3. Kéo khách → 4. ',
                          ),
                          TextSpan(
                            text: 'Nhận hoa hồng trọn đời.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: CagPrimaryButton(
                            text: 'Viết Review Ngay',
                            isGradient: true,
                            textColor: Colors.white,
                            prefixIcon: Icons.edit,
                            borderRadius: 8,
                            height: 50,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CagPrimaryButton(
                            text: 'Ví Của Tôi',
                            isBorder: true,
                            backgroundColor: const Color(
                              0xFF1E293B,
                            ).withOpacity(0.8),
                            boderColor: const Color(0xFF475569),
                            textColor: Colors.white,
                            borderRadius: 8,
                            height: 50,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    Center(child: _buildEarningsCard(450000)),
                  ],
                ),
              ),
            ),
            const CommuTabBar(),

            SliverFillRemaining(
              child: IndexedStack(
                index: selectIndex,
                children: [
                  const Center(
                    child: Text(
                      'Nội dung BẢNG TIN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Nội dung ĐANG THEO DÕI',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Nội dung HỘI BÀN TRÒN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Nội dung TÌM ĐỒNG ĐỘI',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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

  Widget _buildEarningsCard(int earnings) {
    final String formattedEarnings = earnings.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );

    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF020617).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'THU NHẬP THÁNG NÀY',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '$formattedEarnings ₫',
              style: const TextStyle(
                color: Color(0xFF4ADE80),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                // Xử lý rút tiền ở đây
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFF22C55E).withOpacity(0.3),
                  ),
                ),
                child: const Text(
                  'Rút tiền ngay',
                  style: TextStyle(
                    color: Color(0xFF4ADE80),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
