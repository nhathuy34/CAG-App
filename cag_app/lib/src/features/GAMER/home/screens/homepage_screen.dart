import 'package:CAG_App/src/features/GAMER/community/screens/community_screen.dart';
import 'package:CAG_App/src/features/GAMER/profile/screens/profile_screen.dart';
import 'package:CAG_App/src/features/GAMER/cag_guide/screens/cag_guide_screen.dart';
import 'package:CAG_App/src/features/GAMER/scan/screens/scan_screen.dart';
import 'package:CAG_App/src/utils/storage_helper.dart'; // THÊM DÒNG NÀY ĐỂ CHECK LOGIN
import 'package:CAG_App/src/features/authentication/screens/auth_screen.dart'; // THÊM DÒNG NÀY ĐỂ ĐI TỚI AUTH SCREEN
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/features/GAMER/home/providers/nav_provider.dart';
import 'package:CAG_App/src/common_widgets/hexagon_bottom_nav.dart';
import 'package:CAG_App/src/features/GAMER/cloud_save/screens/cloud_save_screen.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  // Hàm hiển thị Popup yêu cầu đăng nhập
  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          "Yêu cầu đăng nhập",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Bạn cần đăng nhập để sử dụng tính năng Cloud Save. Đăng nhập ngay?",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Đóng dialog
            child: const Text(
              "Hủy",
              style: TextStyle(color: Colors.white54),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00FF75),
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context); // Đóng popup
              // Điều hướng tới AuthScreen (Trang Đăng Nhập)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthScreen(isLogin: true),
                ),
              );
            },
            child: const Text(
              "Đăng Nhập",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = ref.watch(navIndexProvider);
    final bool isScanPage = navIndex == 2;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF0b0e14),
      body: Stack(
        children: [
          IndexedStack(
            index: navIndex,
            children: const [
              CommunityScreen(),
              CloudSaveScreen(),
              ScanScreen(), 
              CagGuideScreen(),
              ProfileScreen(),
            ],
          ),

          if (!isScanPage) 
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: HexagonBottomNav(
                currentIndex: navIndex,
                // Chỉnh thành async để có thể await kết quả check login
                onTap: (index) async {
                  // Chỉ check khi người dùng bấm vào tab Cloud Save (index == 1)
                  if (index == 1) {
                    final isLoggedIn = await StorageHelper.isLoggedIn();
                    if (!isLoggedIn) {
                      if (context.mounted) {
                        _showLoginDialog(context);
                      }
                      return; // Dừng việc chuyển tab
                    }
                  }

                  // Đổi tab bình thường nếu đã login hoặc là tab khác
                  ref.read(navIndexProvider.notifier).setIndex(index);
                },
              ),
            ),
        ],
      ),
    );
  }
}