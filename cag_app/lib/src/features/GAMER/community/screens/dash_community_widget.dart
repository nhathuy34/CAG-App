import 'dart:ui';
import 'package:CAG_App/src/features/GAMER/community/providers/community_provider.dart';
import 'package:CAG_App/src/features/authentication/providers/auth_provider.dart';
import 'package:CAG_App/src/features/authentication/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommuTabBar extends ConsumerWidget {
  const CommuTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectIndex = ref.watch(communityTabIndexProvider);

    return SliverPersistentHeader(
      pinned: true, 
      delegate: _SliverAppBarDelegate(
        child: ClipRect( 
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), 
            child: Container(
              padding: const EdgeInsets.only(top: 8), // pt-2
              decoration: BoxDecoration(
                color: const Color(0xFF020617).withOpacity(0.95), 
                border: const Border(
                  bottom: BorderSide(color: Color(0xFF334155), width: 1), 
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // overflow-x-auto
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildTab(
                      ref: ref,
                      index: 0,
                      selectedIndex: selectIndex,
                      label: 'BẢNG TIN',
                      icon: Icons.rss_feed,
                      activeColor: const Color(0xFFF472B6), // text-pink-400
                      borderColor: const Color(0xFFEC4899), // border-pink-500
                    ),
                    _buildTab(
                      ref: ref,
                      index: 1,
                      selectedIndex: selectIndex,
                      label: 'ĐANG THEO DÕI',
                      icon: Icons.person_outline,
                      activeColor: const Color(0xFF4ADE80), // text-green-400
                      borderColor: const Color(0xFF22C55E), // border-green-500
                      needsAuth: true,
                      
                    ),
                    _buildTab(
                      ref: ref,
                      index: 2,
                      selectedIndex: selectIndex,
                      label: 'HỘI BÀN TRÒN',
                      icon: Icons.chat_bubble_outline,
                      activeColor: const Color(0xFF22D3EE), // text-cyan-400
                      borderColor: const Color(0xFF06B6D4), // border-cyan-500
                    ),
                    _buildTab(
                      ref: ref,
                      index: 3,
                      selectedIndex: selectIndex,
                      label: 'TÌM ĐỒNG ĐỘI',
                      icon: Icons.group_add_outlined,
                      activeColor: const Color(0xFF4ADE80), // text-green-400
                      borderColor: const Color(0xFF22C55E), // border-green-500
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab({
    required WidgetRef ref,
    required int index,
    required int selectedIndex,
    required String label,
    required IconData icon,
    required Color activeColor,
    required Color borderColor,
    bool needsAuth = false,
  }) {
    bool isActive = selectedIndex == index;
    final Color inactiveColor = const Color(0xFF94A3B8); // text-slate-400

    return InkWell(
      onTap: () {
        if (needsAuth) {
          // GIẢ SỬ: Check logic đăng nhập thật ở đây
          final authState = ref.read(authStateProvider);
          final bool isLoggedIn = authState != null;

          if (!isLoggedIn) {
            Navigator.of(ref.context).push(
              PageRouteBuilder(
                opaque: false,
                barrierColor: Colors.black26,
                pageBuilder: (context, _, __) => const AuthScreen(isLogin: true),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
            return; // Dừng luôn, không cho đổi tab
          }
        }
        
        // Nếu đã Login hoặc Tab không yêu cầu Auth -> Cho phép đổi Tab
        ref.read(communityTabIndexProvider.notifier).state = index;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? borderColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isActive ? activeColor : inactiveColor),
            const SizedBox(width: 8), // gap-2
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isActive ? activeColor : inactiveColor,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper để xử lý Sticky Header (SliverPersistentHeader)
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.child});
  final Widget child;

  @override
  double get minExtent => 60.0;
  @override
  double get maxExtent => 60.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => true;
}