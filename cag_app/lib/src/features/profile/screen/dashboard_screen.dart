import 'package:flutter/material.dart';
import '../../../common_widgets/hexagon_bottom_nav.dart';
import '../../cag_guide/cag_guide_screen.dart';
import '../../scan/screen.dart';
import '../../zone/zone_screen.dart';
import '../widgets/profile_view.dart'; 

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _bottomNavIndex = 4; // Mặc định mở Profile

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
    return Scaffold(
      backgroundColor: const Color(0xFF050A15),
      body: Stack(
        children: [
          IndexedStack(
            index: _bottomNavIndex,
            children: _mainScreens,
          ),
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: HexagonBottomNav(
              currentIndex: _bottomNavIndex,
              onTap: (index) => setState(() => _bottomNavIndex = index),
            ),
          ),
        ],
      ),
    );
  }
}