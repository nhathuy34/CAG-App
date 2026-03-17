import 'package:flutter/material.dart';

class AppTheme {
  static const Color cyanNeon = Color(0xFF00F2EA);
  static const Color gold = Color(0xFFE8C300);
  
  static const Color darkBg = Color(0xFF000000);
  static const Color cardBg = Color(0xFF0D141A);
  static const Color inputBg = Colors.black26;
  static const Color roleBg = Colors.black26;
  static final Color overlayBlur = Colors.black.withOpacity(0.4);

  static const Color textWhite = Colors.white;
  static const Color textBlack = Colors.black;
  static const Color textGray = Color(0xFFCDC8C8);
  static const Color textDim = Colors.white54;
  static const Color textHint = Colors.white24;
  static const Color textDisabled = Colors.white12;

  static const Color borderWhite = Colors.white10;
  static const Color borderButton = Colors.white38;
  static final Color shadowColor = Colors.black.withOpacity(0.3);

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: darkBg,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputBg,
        hintStyle: const TextStyle(color: textHint, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}