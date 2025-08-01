import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryGreen = Color(0xFF00C853);
  static const Color primaryRed = Color(0xFFFF1744);
  static const Color primaryBlue = Color(0xFF2962FF);
  static const Color primaryOrange = Color(0xFFFF6D00);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Colors.white;
  static const Color lightPrimary = primaryBlue;

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkPrimary = primaryBlue;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightBackground,
      cardColor: lightSurface,

      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: primaryGreen,
        surface: lightSurface,
        error: primaryRed,
      ),

      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        headlineMedium:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        bodyLarge: const TextStyle(color: Colors.black87),
        bodyMedium: const TextStyle(color: Colors.black54),
        bodySmall: const TextStyle(color: Colors.black45),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: lightSurface,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // FIXED: Use CardThemeData instead of CardTheme
      cardTheme: const CardThemeData(
        color: lightSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: darkPrimary,
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkSurface,

      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        secondary: primaryGreen,
        surface: darkSurface,
        error: primaryRed,
      ),

      textTheme:
          GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        headlineLarge:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        headlineMedium:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        bodyLarge: const TextStyle(color: Colors.white),
        bodyMedium: const TextStyle(color: Colors.white70),
        bodySmall: const TextStyle(color: Colors.white54),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // FIXED: Use CardThemeData instead of CardTheme
      cardTheme: const CardThemeData(
        color: darkSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
