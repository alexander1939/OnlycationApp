import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        error: const Color(0xFFD32F2F),
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: const TextStyle(
          color: Color(0xFFD32F2F),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD32F2F)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2),
        ),
      ),
    );
  }

  // Add dark theme if needed
  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    const errorRed = Color(0xFFD32F2F);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(error: errorRed),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        errorStyle: const TextStyle(
          color: errorRed,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: errorRed),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
      ),
    );
  }
}
