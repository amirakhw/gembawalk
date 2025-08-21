import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static final TextStyle titleLarge = GoogleFonts.poppins(
    fontSize: 26.0,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static final TextStyle titleMedium = GoogleFonts.poppins(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.25,
  );

  static final TextStyle titleSmall = GoogleFonts.poppins(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.25,
  );

  static final TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.15,
  );

  static final TextStyle bodySmall = GoogleFonts.poppins(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  static final TextStyle labelLarge = GoogleFonts.poppins(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  static final TextStyle labelMedium = GoogleFonts.poppins(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static final TextStyle button = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
}
