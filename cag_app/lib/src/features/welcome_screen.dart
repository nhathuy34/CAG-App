import 'package:cag_app/src/constants/app_theme.dart';
import 'package:cag_app/src/features/authentication/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: Stack(
        children: [
          // Hình nền
          Positioned.fill(
            child: Image.asset('assets/welcome.png', fit: BoxFit.cover),
          ),

          // Lớp phủ mờ đen để làm nổi bật nội dung
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
            ),
          ),

          // Nội dung chính
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  _buildLogo(),

                  const SizedBox(height: 25),
                  _buildBrandName(),

                  const Spacer(),
                  const Text("CHỌN QUÁN ĐÚNG GU", style: TextStyle(color: AppTheme.textDim, fontSize: 18, fontWeight: FontWeight.bold)),
                  const Text("CHIẾN GAME ĐÚNG CHỖ", style: TextStyle(color: AppTheme.gold, fontSize: 20, fontWeight: FontWeight.w900)),

                  const SizedBox(height: 40),
                  _buildButton(
                    context, 
                    text: "ĐĂNG NHẬP HỘI VIÊN", 
                    color: AppTheme.gold, 
                    textColor: Colors.black,
                    onPressed: () => _navToAuth(context, true),
                  ),

                  const SizedBox(height: 15),
                  _buildButton(
                    context, 
                    text: "ĐĂNG KÝ MỚI", 
                    color: Colors.transparent, 
                    textColor: Colors.white, 
                    isBorder: true,
                    onPressed: () => _navToAuth(context, false),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm _navToAuth để điều hướng đến màn hình đăng nhập/đăng ký
  void _navToAuth(BuildContext context, bool isLogin) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (context, _, __) => AuthScreen(isLogin: isLogin),
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  // Hàm build logo
  Widget _buildLogo() {
    return Transform(
      transform: Matrix4.skewX(-0.15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        color: AppTheme.cyanNeon,
        child: const Text('C', style: TextStyle(color: Colors.black, fontSize: 45, fontWeight: FontWeight.w900)),
      ),
    );
  }

  // Hàm build tên thương hiệu
  Widget _buildBrandName() {
    return Column(
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, letterSpacing: -1),
            children: [
              TextSpan(text: "CAG ", style: TextStyle(color: Colors.white)),
              TextSpan(text: "GUIDE", style: TextStyle(color: AppTheme.cyanNeon)),
            ],
          ),
        ),
        Container(height: 5, width: 180, color: AppTheme.gold),
      ],
    );
  }

  // Hàm build nút bấm
  Widget _buildButton(BuildContext context, {required String text, required Color color, required Color textColor, required VoidCallback onPressed, bool isBorder = false}) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: isBorder ? const BorderSide(color: Colors.white38, width: 1.5) : BorderSide.none,
          ),
        ),
        child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w900, fontSize: 16)),
      ),
    );
  }
}