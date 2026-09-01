import 'package:flutter/material.dart';

class AppTheme {
  // ---- Woolworths-style E-commerce Palette ----
  static const Color primary        = Color(0xFF00A651);   // Woolworths green
  static const Color primaryDark    = Color(0xFF008C44);
  static const Color primaryLight   = Color(0xFFE8F5E9);
  static const Color secondary      = Color(0xFF1A1A2E);
  static const Color accent         = Color(0xFFFF6B35);   // orange for CTAs
  static const Color accentRed      = Color(0xFFE53935);   // sale/promo red
  static const Color background     = Color(0xFFF8F9FA);   // off-white
  static const Color surface        = Colors.white;
  static const Color textPrimary    = Color(0xFF1A1A2E);
  static const Color textSecondary  = Color(0xFF6B7280);
  static const Color textMuted      = Color(0xFF9CA3AF);
  static const Color border         = Color(0xFFE5E7EB);
  static const Color success        = Color(0xFF00A651);
  static const Color error          = Color(0xFFEF4444);
  static const Color warning        = Color(0xFFF59E0B);
  static const Color discount       = Color(0xFFE53935);

  static const RoundedRectangleBorder _cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: primary,
      onPrimary: Colors.white,
      secondary: secondary,
      surface: surface,
      onSurface: textPrimary,
      error: error,
    ),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: textPrimary,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: textPrimary),
    ),
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      shape: _cardShape,
      margin: EdgeInsets.zero,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primary, width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: error)),
      hintStyle: const TextStyle(color: textSecondary),
      labelStyle: const TextStyle(color: textSecondary),
    ),
    listTileTheme: const ListTileThemeData(iconColor: textSecondary),
  );
}
