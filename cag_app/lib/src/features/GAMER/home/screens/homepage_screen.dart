import 'package:CAG_App/src/features/GAMER/profile/screens/profile_screen.dart';
import 'package:CAG_App/src/features/GAMER/cag_guide/screens/cag_guide_screen.dart';
import 'package:CAG_App/src/features/GAMER/scan/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:CAG_App/src/features/GAMER/home/providers/nav_provider.dart';
import 'package:CAG_App/src/common_widgets/hexagon_bottom_nav.dart';

class HomePageScreen extends ConsumerWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = ref.watch(navIndexProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0b0e14),
      // Dùng Stack để BottomNav luôn nổi lên trên cùng (Z-index cao hơn)
      body: Stack(
        children: [
          // Lớp dưới: Nội dung màn hình
          IndexedStack(
            index: navIndex,
            children: [
              const Center(child: Text("Cộng đồng")),
              const Center(child: Text("Cloud Save")),
              ScanScreen(),
              CagGuideScreen(),
              ProfileScreen(),
            ],
          ),

          // Lớp trên: Thanh điều hướng
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HexagonBottomNav(
              currentIndex: navIndex,
              onTap: (index) {
                ref.read(navIndexProvider.notifier).state = index;
              },
            ),
          ),
        ],
      ),
    );
  }
}
