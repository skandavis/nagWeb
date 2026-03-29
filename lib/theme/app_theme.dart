import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.deepThemeColor,
        secondary: AppColors.gold,
        surface: AppColors.warmWhite,
        onPrimary: AppColors.ivory,
        onSurface: AppColors.textPrimary,
      ),
      scaffoldBackgroundColor: AppColors.warmWhite,
      textTheme: GoogleFonts.cormorantGaramondTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 56, fontWeight: FontWeight.w400,
          color: AppColors.ivory, height: 1.05,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 40, fontWeight: FontWeight.w400,
          color: AppColors.textPrimary, height: 1.15,
        ),
        headlineLarge: GoogleFonts.cinzel(
          fontSize: 14, fontWeight: FontWeight.w500,
          letterSpacing: 3.0, color: AppColors.gold,
        ),
        bodyLarge: GoogleFonts.cormorantGaramond(
          fontSize: 18, fontWeight: FontWeight.w300,
          color: AppColors.textSecondary, height: 1.85,
        ),
        bodyMedium: GoogleFonts.cormorantGaramond(
          fontSize: 15, fontWeight: FontWeight.w300,
          color: AppColors.textSecondary, height: 1.75,
        ),
        labelLarge: GoogleFonts.cinzel(
          fontSize: 11, fontWeight: FontWeight.w500,
          letterSpacing: 2.5, color: AppColors.ivory,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.warmWhite,
        elevation: 0,
        titleTextStyle: GoogleFonts.cinzel(
          fontSize: 15, fontWeight: FontWeight.w500,
          letterSpacing: 1.8, color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.warmWhite,
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
