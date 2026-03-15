import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'auth_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool _isHoverLogin = false;
  bool _isHoverRegister = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: AppColors.backgroundDark);
            },
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  const Spacer(),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform(
                          transform: Matrix4.skewX(-0.25),
                          alignment: Alignment.center,
                          child: Container(
                            width: 75,
                            height: 85,
                            color: AppColors.cyanPrimary,
                          ),
                        ),
                        const Text(
                          'C',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: 'CAG ', style: TextStyle(color: AppColors.textWhite)),
                          TextSpan(text: 'GUIDE', style: TextStyle(color: AppColors.cyanPrimary)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Container(width: 60, height: 3, color: AppColors.yellowPrimary),
                  ),
                  const SizedBox(height: 24),
                  Text.rich(
                    const TextSpan(
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2, height: 1.5),
                      children: [
                        TextSpan(text: 'CHỌN QUÁN ĐÚNG GU\n', style: TextStyle(color: AppColors.textWhite)),
                        TextSpan(text: 'CHIẾN GAME ĐÚNG CHỖ', style: TextStyle(color: AppColors.yellowPrimary)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  _buildMenuButton(
                    label: 'ĐĂNG NHẬP HỘI VIÊN',
                    icon: Icons.login,
                    isHover: _isHoverLogin,
                    color: AppColors.yellowPrimary,
                    textColor: Colors.black,
                    onHover: (v) => setState(() => _isHoverLogin = v),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AuthScreen(initialIndex: 0))),
                  ),
                  const SizedBox(height: 16),
                  _buildMenuButton(
                    label: 'ĐĂNG KÝ MỚI',
                    isHover: _isHoverRegister,
                    color: Colors.black,
                    textColor: AppColors.textWhite,
                    isOutlined: true,
                    onHover: (v) => setState(() => _isHoverRegister = v),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AuthScreen(initialIndex: 1))),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'BỎ QUA, TÔI MUỐN THAM QUAN APP TRƯỚC',
                        style: TextStyle(color: AppColors.textWhite, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton({
    required String label,
    required bool isHover,
    required Color color,
    required Color textColor,
    required Function(bool) onHover,
    required VoidCallback onTap,
    IconData? icon,
    bool isOutlined = false,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedScale(
        scale: isHover ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              side: isOutlined ? const BorderSide(color: Colors.white24) : BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: textColor, size: 22),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}