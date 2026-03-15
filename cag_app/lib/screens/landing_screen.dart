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
          Container(
            color: AppColors.backgroundDark,
            child: Image.asset('assets/background.png', fit: BoxFit.cover),
          ),
          Container(
            color: Colors.black,
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
                  Listener(
                    onPointerDown: (_) => setState(() => _isHoverLogin = true),
                    onPointerUp: (_) => setState(() => _isHoverLogin = false),
                    child: MouseRegion(
                      onEnter: (_) => setState(() => _isHoverLogin = true),
                      onExit: (_) => setState(() => _isHoverLogin = false),
                      child: AnimatedScale(
                        scale: _isHoverLogin ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 150),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.yellowPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AuthScreen(initialIndex: 0)),
                            );
                          },
                          icon: const Icon(Icons.login, color: Colors.black, size: 22),
                          label: const Text(
                            'ĐĂNG NHẬP HỘI VIÊN',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Listener(
                    onPointerDown: (_) => setState(() => _isHoverRegister = true),
                    onPointerUp: (_) => setState(() => _isHoverRegister = false),
                    child: MouseRegion(
                      onEnter: (_) => setState(() => _isHoverRegister = true),
                      onExit: (_) => setState(() => _isHoverRegister = false),
                      child: AnimatedScale(
                        scale: _isHoverRegister ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 150),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const AuthScreen(initialIndex: 1)),
                            );
                          },
                          child: const Text(
                            'ĐĂNG KÝ MỚI',
                            style: TextStyle(color: AppColors.textWhite, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
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
}