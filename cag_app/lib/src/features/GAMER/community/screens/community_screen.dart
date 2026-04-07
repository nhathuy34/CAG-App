import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/community/providers/community_provider.dart';
import 'package:CAG_App/src/features/GAMER/community/screens/dash_community_widget.dart';
import 'package:CAG_App/src/features/GAMER/home/providers/nav_provider.dart';
import 'package:CAG_App/src/features/authentication/providers/auth_provider.dart';
import 'package:CAG_App/src/features/authentication/screens/auth_screen.dart';
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
    
    // Kiểm tra trạng thái đăng nhập
    final authState = ref.watch(authStateProvider);
    final bool isLoggedIn = authState != null;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header Banner (Truyền trạng thái đăng nhập vào)
            SliverToBoxAdapter(child: _buildBannerHeader(isLoggedIn)),

            // TabBar (Sticky)
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

  Widget _buildBannerHeader(bool isLoggedIn) {
    // Lấy kích thước màn hình thực tế
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Setup biến "Co giãn": Nếu màn hình nhỏ (< 380) thì dùng size nhỏ
    final bool isSmallScreen = screenWidth < 380;
    final double titleSize = isSmallScreen ? 20 : 26; // Chữ tiêu đề
    final double buttonHeight = isSmallScreen ? 42 : 48; // Chiều cao nút
    final double buttonFontSize = isSmallScreen ? 11 : 13; // Size chữ trong nút

    return Container(
      margin: const EdgeInsets.all(16),
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4C1D95), Color(0xFF312E81)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF7E22CE).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _animationPulseBadge("REVIEW TO EARN"),
          const SizedBox(height: 8),
          
          // Tiêu đề tự co giãn
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                letterSpacing: -0.5,
              ),
              children: const [
                TextSpan(text: 'BẠN CHƠI - BẠN REVIEW - ', style: TextStyle(color: Colors.white)),
                TextSpan(text: 'BẠN CÓ TIỀN', style: TextStyle(color: Color(0xFF22D3EE))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Quy trình kiếm tiền:\n1. Chơi game tại quán → 2. Viết Review → 3. Kéo khách đến chơi → 4. Nhận hoa hồng trọn đời.',
            style: TextStyle(
              color: Colors.white70, 
              fontSize: isSmallScreen ? 11 : 13,
              height: 1.6
            ),
          ),
          const SizedBox(height: 20),
          
          // --- BỘ NÚT BẤM ---
          Row(
            children: [
              Expanded(
                child: CagPrimaryButton(
                  text: 'Viết Review Ngay',
                  isGradient: true,
                  prefixIcon: Icons.edit_outlined,
                  height: buttonHeight,
                  fontSize: buttonFontSize,
                  borderRadius: 12,
                  onPressed: () {
                    if (!isLoggedIn) {
                      _showAuthPopup(); // Chưa login thì gọi popup mờ
                    } else {
                      // Đã login thì hiện thông báo tính năng
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tính năng đang được phát triển!'),
                          backgroundColor: AppTheme.primary,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 8), // Giảm khoảng cách cho máy nhỏ dễ thở
              Expanded(
                child: CagPrimaryButton(
                  text: 'Ví Của Tôi',
                  isBorder: true,
                  backgroundColor: const Color(0xFF1E293B),
                  boderColor: const Color(0xFF475569),
                  height: buttonHeight,
                  fontSize: buttonFontSize,
                  borderRadius: 12,
                  onPressed: () {
                    if (!isLoggedIn) {
                      _showAuthPopup(); // Chưa login thì gọi popup mờ
                    } else {
                      // Đã login thì nhảy sang tab Ví
                      ref.read(navIndexProvider.notifier).setIndex(4);
                    }
                  },
                ),
              ),
            ],
          ),
          
          // --- CHỈ HIỆN CARD THU NHẬP KHI ĐÃ LOGIN ---
          if (isLoggedIn) ...[
            const SizedBox(height: 24),
            Center(child: _buildMonthlyIncomeCard()),
          ],
        ],
      ),
    );
  }

  // Hàm gọi Popup mờ ảo
  void _showAuthPopup() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black26,
        pageBuilder: (context, _, __) => const AuthScreen(isLogin: true),
        transitionsBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  Widget _buildMonthlyIncomeCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 240),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withOpacity(0.6), // Nền card tối theo ảnh
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'THU NHẬP THÁNG NÀY',
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                '0',
                style: TextStyle(color: Color(0xFF4ADE80), fontSize: 42, fontWeight: FontWeight.w900),
              ),
              const SizedBox(width: 8),
              Text(
                'đ',
                style: TextStyle(
                  color: const Color(0xFF4ADE80),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF4ADE80),
                  decorationThickness: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF064E3B),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'Rút tiền ngay',
              style: TextStyle(color: Color(0xFF4ADE80), fontSize: 11, fontWeight: FontWeight.bold),
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