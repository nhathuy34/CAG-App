import 'package:cag_app/Screens/login/register/auth_screen.dart';
import 'package:cag_app/src/constants/app_theme.dart';
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
          // Nền ảnh bao phủ toàn bộ
          Positioned.fill(
            child: Image.asset(
              'assets/welcome.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // Lớp phủ tối phía dưới để làm nổi bật text (Overlay)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Logo 'C' nghiêng đặc trưng
                  Transform(
                    transform: Matrix4.skewX(-0.15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      decoration: const BoxDecoration(
                        color: AppTheme.cyanNeon,
                      ),
                      child: const Text(
                        'C',
                        style: TextStyle(
                          color: AppTheme.darkBg,
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  // App Name: CAG GUIDE
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 48, 
                        fontWeight: FontWeight.w900, 
                        letterSpacing: -1,
                        fontFamily: 'Orbitron', // Nếu bạn có font gaming
                      ),
                      children: [
                        TextSpan(text: "CAG ", style: TextStyle(color: Colors.white)),
                        TextSpan(text: "GUIDE", style: TextStyle(color: Color(0xFFE3293f4))),
                      ],
                    )
                  ),
                  
                  // Thanh kẻ vàng nhỏ dưới tên app
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 5,
                    width: 150,
                    decoration: BoxDecoration(
                      color: AppTheme.gold,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const Spacer(),
                  
                  // Slogan
                  const Text(
                    "CHỌN QUÁN ĐÚNG GU",
                    style: TextStyle(color: AppTheme.textDim, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "CHIẾN GAME ĐÚNG CHỖ",
                    style: TextStyle(color: AppTheme.gold, fontSize: 20, fontWeight: FontWeight.w900),
                  ),

                  const SizedBox(height: 40),

                  // Nút Đăng nhập hội viên (Vàng)
                  _buildButton(
                    text: "ĐĂNG NHẬP HỘI VIÊN",
                    color: AppTheme.gold,
                    textColor: Colors.black,
                    icon: Icons.login_rounded,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => const AuthScreen(isLogin: true)
                    )),
                  ),

                  const SizedBox(height: 15),

                  // Nút Đăng ký mới (Viền trắng)
                  _buildButton(
                    text: "ĐĂNG KÝ MỚI",
                    color: Colors.transparent,
                    textColor: Colors.white,
                    isBorder: true,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => const AuthScreen(isLogin: false)
                    )),
                  ),

                  const SizedBox(height: 25),

                  // Lựa chọn bỏ qua phía dưới cùng
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "BỎ QUA, TÔI MUỐN THAM QUAN APP TRƯỚC",
                          style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward, color: Colors.white54, size: 14),
                      ],
                    ),
                  ),
                  
                  const Text(
                    "POWERED BY CAG PRO ECOSYSTEM",
                    style: TextStyle(color: Colors.white24, fontSize: 10, letterSpacing: 1),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
    IconData? icon,
    bool isBorder = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: isBorder ? const BorderSide(color: Colors.white38, width: 1.5) : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: textColor),
              const SizedBox(width: 12),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor, 
                fontWeight: FontWeight.w900, 
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}