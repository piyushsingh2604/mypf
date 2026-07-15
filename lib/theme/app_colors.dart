import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Primary backgrounds ──
  static const Color background = Color(0xFFFAFAFA);       // mocha-50
  static const Color backgroundAlt = Color(0xFFF4F4F5);    // mocha-100
  static const Color backgroundMuted = Color(0xFFF0F0F0);  // mocha-150
  static const Color cardBg = Color(0xFFFFFFFF);            // white

  // ── Text colors ──
  static const Color textPrimary = Color(0xFF18181B);       // mocha-700
  static const Color textSecondary = Color(0xFF52525B);     // mocha-600
  static const Color textMuted = Color(0xFF71717A);         // mocha-500
  static const Color textLight = Color(0xFFA1A1AA);         // mocha-400
  static const Color textOnAccent = Color(0xFFFFFFFF);      // white

  // ── Accent ──
  static const Color accent = Color(0xFF2563EB);            // blue-600
  static const Color accentHover = Color(0xFF1D4ED8);       // blue-700
  static const Color accentLight = Color(0x1A2563EB);       // accent/10
  static const Color accentMedium = Color(0x242563EB);      // accent/14

  // ── Borders & dividers ──
  static const Color border = Color(0xFFE4E4E7);            // mocha-200
  static const Color borderLight = Color(0x73E4E4E7);       // mocha-200/45
  static const Color borderMedium = Color(0xCCE4E4E7);      // mocha-200/80

  // ── Status ──
  static const Color successBg = Color(0xFFECFDF5);         // emerald-50
  static const Color successText = Color(0xFF047857);        // emerald-700
  static const Color successBorder = Color(0xFFA7F3D0);     // emerald-200
  static const Color warningBg = Color(0xFFFFFBEB);          // amber-50
  static const Color warningText = Color(0xFF92400E);        // amber-900

  // ── Shadows (used in BoxShadow) ──
  static const Color shadowLight = Color(0x1A09090B);       // 10% black
  static const Color shadowMedium = Color(0x1409090B);       // 8% black
  static const Color shadowHeavy = Color(0x40000000);        // 25% black

  // ── Card gradients / overlays ──
  static const Color cardOverlay = Color(0x73FFFFFF);        // white/45
  static const Color cardOverlayHover = Color(0xBFFFFFFF);   // white/75

  // ── Legacy compatibility aliases ──
  static const Color smokyBlack = background;
  static const Color eerieBlack1 = backgroundAlt;
  static const Color eerieBlack2 = cardBg;
  static const Color jet = border;
  static const Color onyx = backgroundMuted;
  static const Color orangeYellowCrayola = accent;
  static const Color vegasGold = accentHover;
  static const Color lightGray = textSecondary;
  static const Color lightGray70 = textMuted;
  static const Color white1 = textPrimary;
  static const Color white2 = textPrimary;
  static const Color bittersweetShimmer = Color(0xFFDC2626);

  static const Color gradientOnyxLight = cardBg;
  static const Color gradientOnyxDark = backgroundAlt;

  static const List<Color> goldGradient = [accent, accentHover];
  static const List<Color> onyxGradient = [cardBg, backgroundAlt];
  static const List<Color> goldOverlay1 = [accentLight, Color(0x00000000)];
  static const List<Color> goldOverlay2 = [accentLight, Color(0x00000000)];
}