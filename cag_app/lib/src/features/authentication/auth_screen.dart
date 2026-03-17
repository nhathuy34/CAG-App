import 'dart:ui';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/authentication/auth_provider.dart';
import 'package:CAG_App/src/features/authentication/login_form.dart';
import 'package:CAG_App/src/features/authentication/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  final bool isLogin;
  const AuthScreen({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final isGamer = ref.watch(isGamerProvider);
    final formHeight = ref.watch(authFormHeightProvider);
    final activeColor = isGamer==1 ? AppTheme.cyanNeon : isGamer==2 ? AppTheme.gold : AppTheme.redNeon;

    return DefaultTabController(
      initialIndex: isLogin ? 0 : 1,
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
                    color: AppTheme.cardBg.withOpacity(0.85), 
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppTheme.cyanNeon, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.cyanNeon.withOpacity(0.3),
                        blurRadius: 40,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  // Nội dung Form bên trong
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tab chính giữa và nút X bên phải
                      _buildTopBar(context),
                      const SizedBox(height: 25),

                      // TabView chứa nội dung Form
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: formHeight,
                        child: TabBarView(
                          children: [
                            LoginForm(),
                            RegisterForm(activeColor: activeColor, isGamer: isGamer),
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
}