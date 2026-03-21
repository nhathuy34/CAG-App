import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common_widgets/hexagon_bottom_nav.dart';
import '../../cag_guide/cag_guide_screen.dart';
import '../../scan/screen.dart';
import '../../zone/zone_screen.dart';
import '../../navigation_provider.dart';
import '../widgets/profile_view.dart'; 

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // Danh sách màn hình - Cực kỳ gọn!
  final List<Widget> _mainScreens = [
    const ZoneScreen(),       // 0
    const Center(child: Text("Cloud Save")), // 1
    const ScanScreen(),       // 2
    const CagGuideScreen(),   // 3
    const ProfileView(),      // 4 (Gọi cái class mình vừa tách ở trên)
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF050A15),
      body: Stack(
        children: [
          IndexedStack(
            index: bottomNavIndex,
            children: _mainScreens,
          ),
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: HexagonBottomNav(
              currentIndex: bottomNavIndex,
              onTap: (index) => ref.read(navigationIndexProvider.notifier).state = index,
            ),
          ),
        ],
      ),
    );
  }
}