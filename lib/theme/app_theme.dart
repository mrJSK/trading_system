// theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color primaryGreen = Color(0xFF00D09C);
  static const Color primaryDark = Color(0xFF1F2937);
  static const Color cardBackground = Color(0xFFF8FAFC);
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color profitGreen = Color(0xFF10B981);
  static const Color lossRed = Color(0xFFEF4444);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkCardBackground = Color(0xFF1F2937);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkBorderColor = Color(0xFF374151);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: const CardThemeData(
      color: cardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: borderColor, width: 1),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: Colors.green,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: darkBackground,
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: darkTextPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: const CardThemeData(
      color: darkCardBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: darkBorderColor, width: 1),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: darkTextPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        color: darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: darkTextPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: darkTextSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  // Helper methods to get colors based on current theme
  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : textPrimary;
  }

  static Color getTextSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondary
        : textSecondary;
  }

  static Color getCardBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCardBackground
        : cardBackground;
  }

  static Color getBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorderColor
        : borderColor;
  }
}
