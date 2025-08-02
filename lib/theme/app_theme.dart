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

  // Enhanced gradient colors for premium look
  static const Color gradientStart = Color(0xFF00D09C);
  static const Color gradientEnd = Color(0xFF0891B2);
  static const Color surfaceLight = Color(0xFFFAFBFC);
  static const Color surfaceDark = Color(0xFF0F1419);

  // Status colors
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color infoBlue = Color(0xFF3B82F6);
  static const Color successGreen = Color(0xFF059669);
  static const Color errorRed = Color(0xFFDC2626);

  // Quality grade colors
  static const Color gradeA = Color(0xFF059669);
  static const Color gradeB = Color(0xFF0891B2);
  static const Color gradeC = Color(0xFFF59E0B);
  static const Color gradeD = Color(0xFFDC2626);

  // Risk level colors
  static const Color lowRisk = Color(0xFF059669);
  static const Color mediumRisk = Color(0xFFF59E0B);
  static const Color highRisk = Color(0xFFDC2626);

  // Market cap colors
  static const Color largeCap = Color(0xFF3B82F6);
  static const Color midCap = Color(0xFFF59E0B);
  static const Color smallCap = Color(0xFF8B5CF6);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Inter',
    colorScheme: const ColorScheme.light(
      primary: primaryGreen,
      secondary: infoBlue,
      surface: surfaceLight,
      background: Colors.white,
      error: errorRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimary,
      onBackground: textPrimary,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),
    cardTheme: CardThemeData(
      color: cardBackground,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: borderColor, width: 0.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: primaryGreen.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryGreen,
        side: const BorderSide(color: primaryGreen, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: textPrimary,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        color: textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
        letterSpacing: -0.25,
      ),
      headlineSmall: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      titleLarge: TextStyle(
        color: textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      titleMedium: TextStyle(
        color: textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
      titleSmall: TextStyle(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
      bodyLarge: TextStyle(
        color: textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        height: 1.4,
      ),
      bodySmall: TextStyle(
        color: textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        height: 1.3,
      ),
      labelLarge: TextStyle(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
      labelMedium: TextStyle(
        color: textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
      labelSmall: TextStyle(
        color: textSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: cardBackground,
      selectedColor: primaryGreen.withOpacity(0.1),
      labelStyle: const TextStyle(
        color: textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: borderColor),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: borderColor,
      thickness: 0.5,
      space: 1,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: Colors.green,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: darkBackground,
    fontFamily: 'Inter',
    colorScheme: const ColorScheme.dark(
      primary: primaryGreen,
      secondary: infoBlue,
      surface: surfaceDark,
      background: darkBackground,
      error: errorRed,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: darkTextPrimary,
      onBackground: darkTextPrimary,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: darkTextPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      iconTheme: IconThemeData(color: darkTextPrimary),
    ),
    cardTheme: CardThemeData(
      color: darkCardBackground,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: darkBorderColor, width: 0.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.black,
        elevation: 2,
        shadowColor: primaryGreen.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryGreen,
        side: const BorderSide(color: primaryGreen, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: darkTextPrimary,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        color: darkTextPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
        letterSpacing: -0.25,
      ),
      headlineSmall: TextStyle(
        color: darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      titleLarge: TextStyle(
        color: darkTextPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      titleMedium: TextStyle(
        color: darkTextPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
      titleSmall: TextStyle(
        color: darkTextSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
      bodyLarge: TextStyle(
        color: darkTextPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        color: darkTextPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        height: 1.4,
      ),
      bodySmall: TextStyle(
        color: darkTextSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        height: 1.3,
      ),
      labelLarge: TextStyle(
        color: darkTextPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
      labelMedium: TextStyle(
        color: darkTextSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
      labelSmall: TextStyle(
        color: darkTextSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: darkCardBackground,
      selectedColor: primaryGreen.withOpacity(0.2),
      labelStyle: const TextStyle(
        color: darkTextPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: darkBorderColor),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: darkBorderColor,
      thickness: 0.5,
      space: 1,
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

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? surfaceDark
        : surfaceLight;
  }

  // Enhanced color helpers for the financial dashboard
  static Color getQualityGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
        return gradeA;
      case 'B':
        return gradeB;
      case 'C':
        return gradeC;
      case 'D':
        return gradeD;
      default:
        return textSecondary;
    }
  }

  static Color getRiskLevelColor(String risk) {
    switch (risk.toLowerCase()) {
      case 'low':
        return lowRisk;
      case 'medium':
        return mediumRisk;
      case 'high':
        return highRisk;
      default:
        return textSecondary;
    }
  }

  static Color getMarketCapColor(double? marketCap) {
    if (marketCap == null) return textSecondary;
    if (marketCap >= 20000) return largeCap;
    if (marketCap >= 5000) return midCap;
    return smallCap;
  }

  static Color getEfficiencyColor(String efficiency) {
    switch (efficiency.toLowerCase()) {
      case 'excellent':
        return successGreen;
      case 'good':
        return infoBlue;
      case 'average':
      case 'adequate':
        return warningOrange;
      case 'poor':
        return errorRed;
      default:
        return textSecondary;
    }
  }

  static LinearGradient getPrimaryGradient() {
    return const LinearGradient(
      colors: [gradientStart, gradientEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static BoxShadow getCardShadow({bool isDark = false}) {
    return BoxShadow(
      color: isDark
          ? Colors.black.withOpacity(0.2)
          : Colors.black.withOpacity(0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
      spreadRadius: 0,
    );
  }

  static BoxDecoration getCardDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: getCardBackground(context),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: getBorderColor(context),
        width: 0.5,
      ),
      boxShadow: [getCardShadow(isDark: isDark)],
    );
  }

  static BoxDecoration getGradientDecoration({
    BorderRadius? borderRadius,
    Color? shadowColor,
  }) {
    return BoxDecoration(
      gradient: getPrimaryGradient(),
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: shadowColor ?? primaryGreen.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
      ],
    );
  }
}
