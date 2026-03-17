import 'package:flutter/material.dart';
import 'package:cag_app/screens/cag_guide_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CAG Gaming App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF0D1321),
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFF020617),
      ),
      home: const CagGuideScreen(),
    );
  }
}
