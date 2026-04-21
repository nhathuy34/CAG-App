import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/admin/screens/moderation_screen.dart';
import 'package:CAG_App/src/features/admin/widgets/admin_sidebar.dart';
import 'package:flutter/material.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedIndex = 0; // 0 là Kiểm Duyệt

  // Danh sách các màn hình chính (Dưới dạng Mock cho các chức năng chưa làm)
  final List<Widget> _screens = [
    const ModerationScreen(),
    const Center(child: Text("DASHBOARD (Chưa phát triển)", style: TextStyle(color: Colors.white))),
    const Center(child: Text("QUẢN LÝ QUÁN (Chưa phát triển)", style: TextStyle(color: Colors.white))),
    const Center(child: Text("THÔNG BÁO (Chưa phát triển)", style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    // Điều kiện phân giải để hiển thị UI dạng Mobile hay Desktop/Tablet ngang
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14), // Nền theo tông đen ám xanh nhẹ
      
      // appBar chỉ hiện trên màn hình nhỏ để bật Drawer (Kéo ra kéo vào)
      appBar: isDesktop
          ? null
          : AppBar(
              backgroundColor: const Color(0xFF0B0F14),
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text("ADMIN DASHBOARD", style: TextStyle(color: Colors.white, fontSize: 14)),
            ),
            
      // Đưa sidebar vào Drawer nếu dùng điện thoại
      drawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: const Color(0xFF0D1117),
              child: AdminSidebar(
                selectedIndex: _selectedIndex,
                onMenuSelected: (index) {
                  setState(() => _selectedIndex = index);
                  Navigator.pop(context); // Đống drawer sau khi chọn
                },
              ),
            ),
      
      body: Row(
        children: [
          // Sidebar cứng ngắc hiển thị nếu là Desktop
          if (isDesktop)
            AdminSidebar(
              selectedIndex: _selectedIndex,
              onMenuSelected: (index) {
                setState(() => _selectedIndex = index);
              },
            ),
          
          // Vùng nội dung chính (mở rộng theo Sidebar)
          Expanded(
            child: Stack(
              children: [
                _screens[_selectedIndex],
                
                // Nút hỗ trợ góc dưới bên phải
                Positioned(
                  right: 30,
                  bottom: 30,
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: AppTheme.cyanNeon,
                    elevation: 0,
                    mini: true,
                    child: const Icon(Icons.settings, color: Colors.black, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
