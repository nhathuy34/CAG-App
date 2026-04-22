import 'package:flutter/material.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/admin/screens/moderation_screen.dart';
import 'package:CAG_App/src/features/admin/widgets/admin_sidebar.dart';
import 'package:CAG_App/src/features/admin/screens/notifications_screen.dart';
// import 'package:CAG_App/src/features/admin/widgets/dashboard_tab_view.dart';
// import 'package:CAG_App/src/features/admin/widgets/dashboard_tab_view.dart';
class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedIndex = 0; 

  final List<Widget> _screens = [
    const ModerationScreen(),
    const Center(
      child: Text(
        "DASHBOARD (Chưa phát triển)",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    const Center(
      child: Text(
        "QUẢN LÝ QUÁN (Chưa phát triển)",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    const NotificationsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      appBar: isDesktop
          ? null
          : AppBar(
              backgroundColor: const Color(0xFF0B0F14),
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                "ADMIN DASHBOARD",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
      drawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: const Color(0xFF0D1117),
              child: AdminSidebar(
                selectedIndex: _selectedIndex,
                onMenuSelected: (index) {
                  setState(() => _selectedIndex = index);
                  Navigator.pop(context);
                },
              ),
            ),
      body: Row(
        children: [
          if (isDesktop)
            AdminSidebar(
              selectedIndex: _selectedIndex,
              onMenuSelected: (index) {
                setState(() => _selectedIndex = index);
              },
            ),

          // Vùng nội dung chính (Đã gỡ bỏ nút Settings tròn)
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}