import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CAG App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundDark,
        primaryColor: AppColors.cyanPrimary,
        fontFamily: 'Roboto',
      ),
      home: const LandingScreen(),
    );
  }
}