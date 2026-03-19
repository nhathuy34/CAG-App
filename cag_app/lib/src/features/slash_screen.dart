import 'package:CAG_App/src/constants/app_theme.dart';
import 'package:CAG_App/src/features/GAMER/homepage_screen.dart';
import 'package:CAG_App/src/features/provider/auth_provider.dart';
import 'package:CAG_App/src/features/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SlashScreen extends ConsumerWidget {
  const SlashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lắng nghe trạng thái Token
    final authState = ref.watch(authCheckerProvider);

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: authState.when(
        loading: () => _buildSplashUI(),

        error: (err, stack) => const WelcomeScreen(),

        data: (role){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (role != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const HomePageScreen(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const WelcomeScreen()),
              );
            }
          });
          return _buildSplashUI();
        }
      ),
    );
  }

  Widget _buildSplashUI() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/CAGPRO_logoonly.png',
            fit: BoxFit.cover,
          ),
        ),

        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
          )
        ),

        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // loading indicator
                const CircularProgressIndicator(
                  color: Colors.cyan,
                  strokeWidth: 4,
                ),
                const SizedBox(height: 20),

                const Text(
                  "Welcome to CAG App",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          )
        )
      ],
    );
  }
}