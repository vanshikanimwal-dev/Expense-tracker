import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Fixed 'StateProvider' error
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

// Top-level provider accessible everywhere
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class AppTheme {
  // Shared text theme logic to keep things DRY
  static TextTheme _buildTextTheme(Brightness brightness) {
    final color = brightness == Brightness.light ? AppColors.textDark : AppColors.white;
    return GoogleFonts.interTextTheme().copyWith(
      headlineLarge: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 32),
      titleLarge: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 24),
      titleMedium: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18),
      bodyMedium: const TextStyle(color: AppColors.textGrey, fontSize: 14, fontWeight: FontWeight.w500),
    );
  }

  // LIGHT THEME (Matches Reference Images)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryTeal,
        primary: AppColors.primaryTeal,
        surface: AppColors.white,
        brightness: Brightness.light,
      ),
      textTheme: _buildTextTheme(Brightness.light),
      cardTheme: CardThemeData( // Fixed CardThemeData vs CardTheme error
        color: AppColors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryTeal,
        foregroundColor: AppColors.white,
        elevation: 4,
        shape: CircleBorder(),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.white,
        indicatorColor: AppColors.primaryTeal.withOpacity(0.1),
      ),
    );
  }

  // DARK THEME (Faithful Adaptation)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0D1011), // Deep navy/black
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryTeal,
        primary: AppColors.primaryTeal,
        surface: const Color(0xFF161B1D), // Slightly lighter surface for cards
        brightness: Brightness.dark,
      ),
      textTheme: _buildTextTheme(Brightness.dark),
      cardTheme: CardThemeData(
        color: const Color(0xFF161B1D),
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      // Keep FAB and UI elements consistent
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryTeal,
        foregroundColor: AppColors.white,
        elevation: 4,
        shape: CircleBorder(),
      ),
    );
  }
}