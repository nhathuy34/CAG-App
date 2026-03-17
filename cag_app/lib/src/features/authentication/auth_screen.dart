import 'dart:ui';
import 'package:cag_app/src/constants/app_theme.dart';
import 'package:cag_app/src/features/authentication/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  final bool isLogin;
  const AuthScreen({super.key, required this.isLogin});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool isGamerSelected = true;

  @override
  Widget build(BuildContext context) {
    final Color activeColor = isGamerSelected ? AppTheme.cyanNeon : AppTheme.gold;

    return DefaultTabController(
      initialIndex: widget.isLogin ? 0 : 1,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent, // Để nhìn thấy background của WelcomeScreen
        body: Stack(
          children: [
            // Hiệu ứng mờ nền
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),

            // Khung Form chính giữa
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D141A).withOpacity(0.85),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppTheme.cyanNeon, width: 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // PHẦN THAY ĐỔI: Tab chính giữa và nút X bên phải
                      _buildTopBar(context),
                      
                      const SizedBox(height: 25),
                      _buildRoleToggle(activeColor),
                      const SizedBox(height: 30),

                      // TabView chứa nội dung Form
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 330),
                        child: TabBarView(
                          children: [
                            LoginForm(activeColor: activeColor),
                            const Center(child: Text("FORM ĐĂNG KÝ", style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildTopBar để tạo thanh Tab và nút X
  Widget _buildTopBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: Stack(
        children: [
          // Thanh Tab nằm chính giữa
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 250,
              child: TabBar(
                dividerColor: Colors.transparent,
                indicatorColor: AppTheme.cyanNeon,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white24,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                tabs: const [
                  Tab(text: "ĐĂNG NHẬP"),
                  Tab(text: "ĐĂNG KÝ"),
                ],
              ),
            ),
          ),
          
          // Nút X nằm bên phải
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.close, 
                color: Colors.white.withOpacity(0.5), 
                size: 26, // Kích thước vừa vặn như hình
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildRoleToggle để chọn giữa GAMER và CHỦ PHÒNG
  Widget _buildRoleToggle(Color activeColor) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(child: _roleOption("GAMER", isGamerSelected, AppTheme.cyanNeon)),
          Expanded(child: _roleOption("CHỦ PHÒNG", !isGamerSelected, AppTheme.gold)),
        ],
      ),
    );
  }

  // Widget _roleOption để tạo từng lựa chọn vai trò
  Widget _roleOption(String title, bool isSelected, Color color) {
    return GestureDetector(
      onTap: () => setState(() => isGamerSelected = (title == "GAMER")),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white24,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}