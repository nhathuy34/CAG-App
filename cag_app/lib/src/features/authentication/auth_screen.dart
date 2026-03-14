import 'dart:ui';
import 'package:cag_app/Screens/login/register/login_form.dart';
import 'package:cag_app/src/constants/app_theme.dart';
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
    // Màu chủ đạo thay đổi dựa trên Role được chọn
    final Color activeColor = isGamerSelected ? AppTheme.cyanNeon : AppTheme.gold;

    return DefaultTabController(
      initialIndex: widget.isLogin ? 0 : 1,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D141A).withOpacity(0.95),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppTheme.cyanNeon.withOpacity(0.3), width: 1.5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 20),
                      
                      _buildRoleToggle(activeColor),
                      const SizedBox(height: 25),

                      SizedBox(
                        height: 300,
                        child: TabBarView(
                          children: [
                            LoginForm(activeColor: activeColor),
                            // RegisterForm(activeColor: activeColor),
                          ],
                        ),
                      ),

                      const Text(
                        "Nhấn phím ESC để thoát",
                        style: TextStyle(color: Colors.white24, fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        TabBar(
          indicatorColor: AppTheme.cyanNeon,
          indicatorWeight: 3,
          labelColor: AppTheme.textWhite,
          unselectedLabelColor: AppTheme.textGray,
          dividerColor: Colors.transparent,
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: "ĐĂNG NHẬP"),
            Tab(text: "ĐĂNG KÝ"),
          ],
        ),
        Positioned(
          right: 0,
          top: 10,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: Colors.white70, size: 24),
          ),
        )
      ],
    );
  }

  Widget _buildRoleToggle(Color activeColor) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: _roleOption("GAMER", isGamerSelected, AppTheme.cyanNeon)),
          Expanded(child: _roleOption("CHỦ PHÒNG MÁY", !isGamerSelected, const Color(0xFFE8C300))),
        ],
      ),
    );
  }

  Widget _roleOption(String title, bool isSelected, Color color) {
    return GestureDetector(
      onTap: () => setState(() => isGamerSelected = (title == "GAMER")),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white54,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}