import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mypf/utils/web_colors.dart';

class WebTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: WebColors.bg,
    primaryColor: WebColors.primary,
    colorScheme: const ColorScheme.dark(
      primary: WebColors.primary,
      secondary: WebColors.secondary,
      tertiary: WebColors.tertiary,
      surface: WebColors.surface,
    ),
    dividerColor: WebColors.glass,
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ).apply(bodyColor: WebColors.text, displayColor: WebColors.text),
    cardTheme: CardThemeData(
      color: WebColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: WebColors.card,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: WebColors.primary, width: 1.5),
      ),
      labelStyle: const TextStyle(color: WebColors.textMuted),
      hintStyle: const TextStyle(color: WebColors.textMuted),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: WebColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: WebColors.bgLight,
    primaryColor: WebColors.primary,
    colorScheme: const ColorScheme.light(
      primary: WebColors.primary,
      secondary: WebColors.secondary,
      tertiary: WebColors.tertiary,
      surface: WebColors.surfaceLight,
    ),
    dividerColor: const Color(0x14000000),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData(brightness: Brightness.light).textTheme,
    ).apply(bodyColor: WebColors.textLight, displayColor: WebColors.textLight),
    cardTheme: CardThemeData(
      color: WebColors.cardLight,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: WebColors.cardLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: WebColors.primary, width: 1.5),
      ),
      labelStyle: const TextStyle(color: WebColors.textLightMuted),
      hintStyle: const TextStyle(color: WebColors.textLightMuted),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: WebColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    ),
  );
}