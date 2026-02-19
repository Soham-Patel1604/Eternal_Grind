import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.deepRed,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.deepRed,
        brightness: Brightness.light,
        primary: AppColors.deepRed,
        secondary: AppColors.mutedGold,
        error: AppColors.cursedRed,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      
      // Card theme
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // button theme
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.pureBlack,
      primaryColor: AppColors.deepRed,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.deepRed,
        secondary: AppColors.mutedGold,
        surface: AppColors.charcoal,
        error: AppColors.cursedRed,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.inter(color: AppColors.offWhite),
        displayMedium: GoogleFonts.inter(color: AppColors.offWhite),
        displaySmall: GoogleFonts.inter(color: AppColors.offWhite),
        headlineLarge: GoogleFonts.inter(color: AppColors.offWhite),
        headlineMedium: GoogleFonts.inter(color: AppColors.offWhite),
        headlineSmall: GoogleFonts.inter(color: AppColors.offWhite),
        titleLarge: GoogleFonts.inter(color: AppColors.offWhite),
        titleMedium: GoogleFonts.inter(color: AppColors.offWhite),
        titleSmall: GoogleFonts.inter(color: AppColors.offWhite),
        bodyLarge: GoogleFonts.inter(color: AppColors.offWhite),
        bodyMedium: GoogleFonts.inter(color: AppColors.offWhite),
        bodySmall: GoogleFonts.inter(color: AppColors.offWhite),
      ),
      
      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.charcoal,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: AppColors.charcoalLight,
            width: 1,
          ),
        ),
      ),
      
      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.pureBlack,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.offWhite),
      ),
      
      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.offWhite,
      ),
      
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepRed,
          foregroundColor: AppColors.offWhite,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Filled button theme
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.deepRed,
          foregroundColor: AppColors.offWhite,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.mutedGold,
        ),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.charcoal,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.charcoalLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.charcoalLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.mutedGold),
        ),
      ),
      
      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.mutedGold;
          }
          return AppColors.charcoalLight;
        }),
        checkColor: WidgetStateProperty.all(AppColors.pureBlack),
      ),
    );
  }
}
