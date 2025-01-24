import 'package:cullinarium/core/utils/constants/app_font_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextTheme extends TextTheme {
  AppTextTheme({
    Color? displayColor,
    Color? bodyColor,
  }) : super(
    // Display Styles
    displayLarge: GoogleFonts.inter(
      fontSize: AppFontSize.displayLarge,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.25,
      color: displayColor ?? AppColors.onBackground,
      height: 1.12,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: AppFontSize.displayMedium,
      fontWeight: FontWeight.w600,
      color: displayColor ?? AppColors.onBackground,
      height: 1.16,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: AppFontSize.displaySmall,
      fontWeight: FontWeight.w600,
      color: displayColor ?? AppColors.onBackground,
      height: 1.22,
    ),

    // Headline Styles
    headlineLarge: GoogleFonts.inter(
      fontSize: AppFontSize.headlineLarge,
      fontWeight: FontWeight.w400,
      color: displayColor ?? AppColors.onBackground,
      height: 1.25,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: AppFontSize.headlineMedium,
      fontWeight: FontWeight.w400,
      color: displayColor ?? AppColors.onBackground,
      height: 1.29,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: AppFontSize.headlineSmall,
      fontWeight: FontWeight.w400,
      color: displayColor ?? AppColors.onBackground,
      height: 1.33,
    ),

    // Title Styles
    titleLarge: GoogleFonts.inter(
      fontSize: AppFontSize.titleLarge,
      fontWeight: FontWeight.w400,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.27,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: AppFontSize.titleMedium,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.50,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: AppFontSize.titleSmall,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.43,
    ),

    // Label Styles
    labelLarge: GoogleFonts.inter(
      fontSize: AppFontSize.labelLarge,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.43,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: AppFontSize.labelMedium,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.33,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: AppFontSize.labelSmall,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: bodyColor ?? AppColors.onBackground,
      height: 1.45,
    ),
  );

  AppTextTheme copyWithDarkMode() {
    return AppTextTheme(
      displayColor: Colors.white,
      bodyColor: Colors.white70,
    );
  }

  TextStyle customSubtitle({Color? color}) {
    return GoogleFonts.inter(
      fontSize: AppFontSize.labelMedium,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.onBackground,
      letterSpacing: 0.15,
    );
  }
}
