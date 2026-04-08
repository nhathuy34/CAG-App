import 'dart:ui';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/authentication/providers/auth_provider.dart';
import 'package:CAG_App/src/features/authentication/widgets/login_form.dart';
import 'package:CAG_App/src/features/authentication/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  final bool isLogin;
  const AuthScreen({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGamer = ref.watch(isGamerProvider);
    final formHeight = ref.watch(authFormHeightProvider);
    final activeColor = isGamer ? AppTheme.cyanNeon : AppTheme.gold;

    return DefaultTabController(
      initialIndex: isLogin ? 0 : 1,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Làm mờ nền (Chỉ cần 1 cái thôi ông thần)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(color: Colors.black.withOpacity(0.5)),
              ),
            ),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    constraints: const BoxConstraints(maxWidth: 400), // Khống chế chiều rộng cho đẹp
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBg.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: activeColor.withOpacity(0.5), width: 1),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTopBar(context),
                        const SizedBox(height: 25),
                        
                        // Khung chứa Form với hiệu ứng co dãn
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          height: formHeight + 20, // Thêm chút padding dư ra cho an toàn
                          child: TabBarView(
                            children: [
                              LoginForm(activeColor: activeColor, isGamer: isGamer),
                              RegisterForm(activeColor: activeColor, isGamer: isGamer),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SizedBox(
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