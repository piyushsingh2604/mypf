import 'dart:ui';

class WebColors {
  static const Color bg = Color(0xFF07080B);
  static const Color surface = Color(0xFF0F1118);
  static const Color card = Color(0xFF1A1D2A);

  static const Color bgLight = Color(0xFFF5F6FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFEEF0F5);

  static const Color primary = Color(0xFFFF3D71);
  static const Color secondary = Color(0xFF00D4FF);
  static const Color tertiary = Color(0xFF00E8C8);

  static const Color text = Color(0xFFF8F9FA);
  static const Color textMuted = Color(0xFF6B7185);
  static const Color textLight = Color(0xFF1A1D2E);
  static const Color textLightMuted = Color(0xFF6B7280);

  static const Color glass = Color(0x14FFFFFF);

  static Color get glassBorder => glass;
  static Color get primaryAccent => primary;
  static Color get secondaryAccent => secondary;
  static Color get tertiaryAccent => tertiary;
  static Color get cardDark => card;
  static Color get backgroundDark => bg;
  static Color get backgroundLight => bgLight;
  static Color get surfaceDark => surface;
  static Color get textPrimary => text;
  static Color get textSecondary => textMuted;
  static Color get textDark => textLight;
  static Color get textDarkSecondary => textLightMuted;
  static Color get accent => primary;
  static Color get accentSecondary => secondary;
  static Color get accentTertiary => tertiary;
  static Color get backroundColor => bg;
  static Color get expColor => card;
  static Color get textColor => text;
  static Color get buttonColor => primary;
}