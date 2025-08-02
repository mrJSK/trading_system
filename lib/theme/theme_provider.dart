import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeProvider);
  return themeMode == ThemeMode.dark;
});

final themeColorsProvider = Provider<ThemeColors>((ref) {
  final isDark = ref.watch(isDarkModeProvider);
  return ThemeColors(isDark: isDark);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  static const String _themeKey = 'theme_mode';
  static const String _systemThemeKey = 'system_theme_preference';

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey);

      if (themeIndex != null &&
          themeIndex >= 0 &&
          themeIndex < ThemeMode.values.length) {
        state = ThemeMode.values[themeIndex];
      } else {
        // Default to system theme if no preference is saved
        state = ThemeMode.system;
        await _saveTheme(ThemeMode.system);
      }
    } catch (e) {
      debugPrint('Error loading theme: $e');
      state = ThemeMode.system;
    }
  }

  Future<void> _saveTheme(ThemeMode theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, theme.index);
    } catch (e) {
      debugPrint('Error saving theme: $e');
    }
  }

  Future<void> setTheme(ThemeMode theme) async {
    state = theme;
    await _saveTheme(theme);
  }

  Future<void> toggleTheme() async {
    switch (state) {
      case ThemeMode.light:
        await setTheme(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        await setTheme(ThemeMode.system);
        break;
      case ThemeMode.system:
        await setTheme(ThemeMode.light);
        break;
    }
  }

  Future<void> setLightTheme() async {
    await setTheme(ThemeMode.light);
  }

  Future<void> setDarkTheme() async {
    await setTheme(ThemeMode.dark);
  }

  Future<void> setSystemTheme() async {
    await setTheme(ThemeMode.system);
  }

  // Enhanced theme cycling: Light -> Dark -> System -> Light
  Future<void> cycleTheme() async {
    switch (state) {
      case ThemeMode.light:
        await setTheme(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        await setTheme(ThemeMode.system);
        break;
      case ThemeMode.system:
        await setTheme(ThemeMode.light);
        break;
    }
  }

  String get currentThemeName {
    switch (state) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  IconData get currentThemeIcon {
    switch (state) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  Future<void> resetToDefault() async {
    await setTheme(ThemeMode.system);
  }
}

class ThemeColors {
  final bool isDark;

  ThemeColors({required this.isDark});

  Color get primary => const Color(0xFF00D09C);
  Color get primaryDark => const Color(0xFF1F2937);

  Color get background => isDark ? const Color(0xFF111827) : Colors.white;

  Color get surface =>
      isDark ? const Color(0xFF1F2937) : const Color(0xFFF8FAFC);

  Color get textPrimary =>
      isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937);

  Color get textSecondary =>
      isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  Color get border =>
      isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  Color get success => const Color(0xFF10B981);
  Color get error => const Color(0xFFEF4444);
  Color get warning => const Color(0xFFF59E0B);
  Color get info => const Color(0xFF3B82F6);

  // Quality grade colors
  Color get gradeA => const Color(0xFF059669);
  Color get gradeB => const Color(0xFF0891B2);
  Color get gradeC => const Color(0xFFF59E0B);
  Color get gradeD => const Color(0xFFDC2626);

  // Risk level colors
  Color get lowRisk => const Color(0xFF059669);
  Color get mediumRisk => const Color(0xFFF59E0B);
  Color get highRisk => const Color(0xFFDC2626);

  // Market cap colors
  Color get largeCap => const Color(0xFF3B82F6);
  Color get midCap => const Color(0xFFF59E0B);
  Color get smallCap => const Color(0xFF8B5CF6);

  Color getQualityColor(String grade) {
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

  Color getRiskColor(String risk) {
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

  Color getMarketCapColor(double? marketCap) {
    if (marketCap == null) return textSecondary;
    if (marketCap >= 20000) return largeCap;
    if (marketCap >= 5000) return midCap;
    return smallCap;
  }

  Color getEfficiencyColor(String efficiency) {
    switch (efficiency.toLowerCase()) {
      case 'excellent':
        return success;
      case 'good':
        return info;
      case 'average':
      case 'adequate':
        return warning;
      case 'poor':
        return error;
      default:
        return textSecondary;
    }
  }

  LinearGradient get primaryGradient => LinearGradient(
        colors: [primary, const Color(0xFF0891B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  BoxShadow get cardShadow => BoxShadow(
        color: isDark
            ? Colors.black.withOpacity(0.2)
            : Colors.black.withOpacity(0.08),
        blurRadius: 8,
        offset: const Offset(0, 2),
        spreadRadius: 0,
      );

  BoxDecoration get cardDecoration => BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border, width: 0.5),
        boxShadow: [cardShadow],
      );

  BoxDecoration get gradientDecoration => BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      );
}

// Convenience provider for getting theme-aware decorations
final cardDecorationProvider = Provider<BoxDecoration>((ref) {
  final colors = ref.watch(themeColorsProvider);
  return colors.cardDecoration;
});

final gradientDecorationProvider = Provider<BoxDecoration>((ref) {
  final colors = ref.watch(themeColorsProvider);
  return colors.gradientDecoration;
});

// Provider for theme state as string (useful for UI display)
final themeStateProvider = Provider<String>((ref) {
  final themeMode = ref.watch(themeProvider);
  switch (themeMode) {
    case ThemeMode.light:
      return 'Light';
    case ThemeMode.dark:
      return 'Dark';
    case ThemeMode.system:
      return 'System';
  }
});

// Provider for theme icon (useful for UI display)
final themeIconProvider = Provider<IconData>((ref) {
  final themeMode = ref.watch(themeProvider);
  switch (themeMode) {
    case ThemeMode.light:
      return Icons.light_mode;
    case ThemeMode.dark:
      return Icons.dark_mode;
    case ThemeMode.system:
      return Icons.brightness_auto;
  }
});
