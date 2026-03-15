import 'package:flutter/material.dart';

class AppTheme {
  static const Color cyanNeon = Color(0xFF00F2EA);
  static const Color gold = Color(0xFFE8C300);
  static const Color darkBg = Color(0xFF000000);
  static const Color inputBg = Colors.black26;
  static const Color textWhite = Colors.white;
  static const Color textDim = Colors.white54;
  static const Color borderWhite = Colors.white10;

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: darkBg,
      // Cấu hình mặc định cho tất cả TextField trong App
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputBg,
        hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}