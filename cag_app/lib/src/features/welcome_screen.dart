import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/authentication/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  _buildLogo(),

                  const SizedBox(height: 5),
                  _buildBrandName(),

                  const SizedBox(height: 20),
                  const Text(
                    "CHỌN QUÁN ĐÚNG GU",
                    style: TextStyle(
                      color: AppTheme.textDim,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "CHIẾN GAME ĐÚNG CHỖ",
                    style: TextStyle(
                      color: AppTheme.gold,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 50),
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

                  _buildFooterLink(context),
                  const SizedBox(height: 10),
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
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Transform(
        transform: Matrix4.skewX(-0.15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.cyanNeon,
            boxShadow: [
              BoxShadow(
                color: AppTheme.cyanNeon.withOpacity(0.6),
                blurRadius: 40,
                spreadRadius: 0.0,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Text(
            'C',
            style: GoogleFonts.rajdhani(
              fontSize: 45,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // Hàm build tên thương hiệu
  Widget _buildBrandName() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "CAG ",
              style: GoogleFonts.rajdhani(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppTheme.cyanNeon, const Color(0xFF3985F5)],
                stops: const [0.2, 1.0],
              ).createShader(bounds),
              child: Text(
                "GUIDE",
                style: GoogleFonts.rajdhani(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 5,
          width: 110,
          decoration: BoxDecoration(
            color: AppTheme.gold,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }

  // Hàm build nút bấm
  Widget _buildButton(
    BuildContext context, {
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
    bool isBorder = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: isBorder
                ? const BorderSide(color: AppTheme.textDim, width: 1.5)
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Hàm build phần bỏ qua đăng nhập
  Widget _buildFooterLink(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            TextButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => const DashboardScreen()),
                // );
              },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                // Thay đổi màu sắc khi hover hoặc nhấn
                foregroundColor: WidgetStateProperty.resolveWith<Color>((
                  states,
                ) {
                  if (states.contains(WidgetState.hovered) ||
                      states.contains(WidgetState.pressed)) {
                    return AppTheme.cyanNeon;
                  }
                  return AppTheme.textDim;
                }),
                padding: WidgetStateProperty.all(EdgeInsets.zero),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "BỎ QUA, TÔI MUỐN THAM QUAN APP TRƯỚC",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "POWERED BY CAG PRO ECOSYSTEM",
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ],
        );
      },
    );
  }
}
