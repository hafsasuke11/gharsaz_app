import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  // LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    scaffoldBackgroundColor:
    AppColors.background,

    primaryColor: AppColors.primary,

    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,

      seedColor: AppColors.primary,
    ),

    textTheme: GoogleFonts.poppinsTextTheme(),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,

      elevation: 0,

      scrolledUnderElevation: 0,

      centerTitle: true,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,

      indicatorColor:
      Colors.green.withValues(alpha: 0.12),
    ),
  );

  // DARK THEME
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    scaffoldBackgroundColor:
    const Color(0xFF0F1115),

    primaryColor: Colors.green,

    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,

      seedColor: Colors.green,
    ),

    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,

      elevation: 0,

      scrolledUnderElevation: 0,

      centerTitle: true,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF1A1D24),

      indicatorColor:
      Colors.green.withValues(alpha: 0.2),
    ),

    cardColor: const Color(0xFF1A1D24),
  );
}