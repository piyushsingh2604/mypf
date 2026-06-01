import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.smokyBlack,
      fontFamily: GoogleFonts.poppins().fontFamily,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.orangeYellowCrayola,
        secondary: AppColors.vegasGold,
        surface: AppColors.eerieBlack2,
        onSurface: AppColors.white2,
        onPrimary: AppColors.smokyBlack,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: AppColors.white2),
          displayMedium: TextStyle(color: AppColors.white2),
          displaySmall: TextStyle(color: AppColors.white2),
          headlineLarge: TextStyle(color: AppColors.white2),
          headlineMedium: TextStyle(color: AppColors.white2),
          headlineSmall: TextStyle(color: AppColors.white2),
          titleLarge: TextStyle(color: AppColors.white2),
          titleMedium: TextStyle(color: AppColors.white2),
          titleSmall: TextStyle(color: AppColors.white2),
          bodyLarge: TextStyle(color: AppColors.lightGray),
          bodyMedium: TextStyle(color: AppColors.lightGray),
          bodySmall: TextStyle(color: AppColors.lightGray70),
          labelLarge: TextStyle(color: AppColors.white2),
          labelMedium: TextStyle(color: AppColors.lightGray70),
          labelSmall: TextStyle(color: AppColors.lightGray70),
        ),
      ),
    );
  }
}