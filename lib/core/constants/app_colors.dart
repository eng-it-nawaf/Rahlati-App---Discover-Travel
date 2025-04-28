import 'package:flutter/material.dart';

class AppColors {
  // static const Color primary = Color(0xFF4CAF50);
  // static const Color secondary = Color(0xFF8BC34A);
  static const Color accent = Color(0xFFFFC107);
  static const Color textDark = Color(0xFF212121);
  static const Color textLight = Color(0xFF757575);



  static const Color primary = Color(0xFF0065FF);
  static const Color primaryLight = Color(0xFFE6F0FF);
  static const Color primaryDark = Color(0xFF0047B3);

  // Secondary Colors
  static const Color secondary = Color(0xFF00C9A7);
  static const Color secondaryLight = Color(0xFFE0F7F2);

  // Background Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A2E35);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textDisabled = Color(0xFFADB5BD);

  // Status Colors
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFDC3545);
  static const Color info = Color(0xFF17A2B8);

  // Border Colors
  static const Color border = Color(0xFFE9ECEF);

  // Gradient Colors
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0065FF), Color(0xFF00C9A7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}