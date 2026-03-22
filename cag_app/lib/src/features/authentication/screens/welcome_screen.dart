import 'package:CAG_App/src/common_widgets/cag_primary_button.dart';
import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/home/screens/homepage_screen.dart';
import 'package:CAG_App/src/features/authentication/screens/auth_screen.dart';
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
          Positioned.fill(
            child: Image.asset('assets/welcome.png', fit: BoxFit.cover),
          ),

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

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  _buildLogo(),

                  const SizedBox(height: 25),
                  _buildBrandName(),

                  const SizedBox(height: 20),
                  const Text(
                    "CHỌN QUÁN ĐÚNG GU",
                    style: TextStyle(
                      color: Color.fromARGB(175, 255, 255, 255),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "CHIẾN GAME ĐÚNG CHỖ",
                    style: TextStyle(
                      color: AppTheme.gold,
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 50),
                  CagPrimaryButton(
                    text: "ĐĂNG NHẬP HỘI VIÊN",
                    prefixIcon: Icons.login,
                    backgroundColor: AppTheme.gold,
                    onPressed: () => _navToAuth(context, true),
                  ),

                  const SizedBox(height: 15),

                  CagPrimaryButton(
                    text: "ĐĂNG KÝ MỚI",
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

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(
        10.0,
      ), // Cho khoảng trống bằng với blurRadius
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
        RichText(
          text: TextSpan(
            style: GoogleFonts.rajdhani(
              fontSize: 48,
              fontWeight: FontWeight.w900,
            ),
            children: [
              const TextSpan(
                text: "CAG ",
                style: TextStyle(color: Colors.white),
              ),
              const TextSpan(
                text: "GUI",
                style: TextStyle(
                  color: Color(0xFF00E5FF),
                ), // Bác có thể dùng AppTheme.cyanNeon ở đây
              ),
              const TextSpan(
                text: "DE",
                style: TextStyle(
                  color: Color(0xFF3B82F6),
                ), // Mã màu xanh dương (bác tự chỉnh lại cho chuẩn màu Figma nhé)
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 5,
          width: 110,
          decoration: BoxDecoration(
            color: AppTheme.gold, // Màu vạch vàng
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePageScreen()),
                );
              },
              style: ButtonStyle(
                // Loại bỏ hiệu ứng mặc định của TextButton
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                // Thay đổi màu sắc khi hover hoặc nhấn
                foregroundColor: WidgetStateProperty.resolveWith<Color>((
                  states,
                ) {
                  if (states.contains(WidgetState.hovered) ||
                      states.contains(WidgetState.pressed)) {
                    return AppTheme.cyanNeon; // Màu khi rê chuột vào hoặc nhấn
                  }
                  return AppTheme.textDim; // Màu xám mặc định
                }),
                padding: WidgetStateProperty.all(EdgeInsets.zero),
              ),
              child: Row(
                mainAxisSize:
                    MainAxisSize.min, // Để Row không chiếm hết chiều ngang
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
