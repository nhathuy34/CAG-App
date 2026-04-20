import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/home/screens/homepage_screen.dart';
import 'package:CAG_App/src/features/authentication/providers/auth_provider.dart';
import 'package:CAG_App/src/features/authentication/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SlashScreen extends ConsumerWidget {
  const SlashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authCheckerProvider, (previous, next) {
      next.whenData((role) {
        if (role != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePageScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          );
        }
      });
    });

    final authState = ref.watch(authCheckerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14), 
      body: authState.when(
        loading: () => _buildSplashUI(),
        error: (err, stack) => const WelcomeScreen(),
        data: (_) => _buildSplashUI(), 
      ),
    );
  }

  Widget _buildSplashUI() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0xFF1E2330), // Sáng nhẹ ở tâm
            Color(0xFF0B0E14), // Đen dần ra viền
          ],
          radius: 1.2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/CAGPRO_logoonly.png',
            width: 160, 
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 60),

          
          Text(
            "SYSTEM INITIALIZING...",
            style: GoogleFonts.ibmPlexMono(
              color: AppTheme.cyanNeon, 
              fontSize: 12,
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          
          SizedBox(
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const LinearProgressIndicator(
                backgroundColor: Colors.white10,
                color: AppTheme.cyanNeon, 
                minHeight: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
