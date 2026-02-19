import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  // Headings (Serif font - Cinzel)
  static TextStyle get h1 => GoogleFonts.cinzel(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.offWhite,
      );

  static TextStyle get h2 => GoogleFonts.cinzel(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.offWhite,
      );

  static TextStyle get h3 => GoogleFonts.cinzel(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.offWhite,
      );

  // Body text (Monospaced font - Roboto Mono)
  static TextStyle get body => GoogleFonts.robotoMono(
        fontSize: 14,
        color: AppColors.offWhite,
      );

  static TextStyle get bodySmall => GoogleFonts.robotoMono(
        fontSize: 12,
        color: AppColors.dimWhite,
      );

  // Emphasis
  static TextStyle get emphasis => GoogleFonts.robotoMono(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.offWhite,
      );

  // Streak counter (large, prominent)
  static TextStyle get streakCounter => GoogleFonts.cinzel(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        color: AppColors.mutedGold,
        letterSpacing: 2,
      );

  // Milestone messages (italic serif)
  static TextStyle get milestone => GoogleFonts.cinzel(
        fontSize: 18,
        fontStyle: FontStyle.italic,
        color: AppColors.gold,
        height: 1.5,
      );

  // Cursed state text
  static TextStyle get cursedWarning => GoogleFonts.cinzel(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.cursedRed,
      );

  static TextStyle get cursedStatus => GoogleFonts.robotoMono(
        fontSize: 12,
        fontStyle: FontStyle.italic,
        color: AppColors.crimson,
      );

  // Button text
  static TextStyle get button => GoogleFonts.robotoMono(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.offWhite,
      );
}
