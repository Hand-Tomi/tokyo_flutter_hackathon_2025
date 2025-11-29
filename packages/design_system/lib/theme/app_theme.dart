import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// StorySpark 앱 테마
///
/// Material Theme을 StorySpark 스타일로 커스터마이징
abstract final class AppTheme {
  /// 라이트 테마 (기본)
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: _colorScheme,
        scaffoldBackgroundColor: AppColors.sky,
        textTheme: _textTheme,
        iconTheme: const IconThemeData(
          color: AppColors.textPrimary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonOrange,
            foregroundColor: AppColors.textPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
          ),
        ),
      );

  /// 색상 스키마
  static ColorScheme get _colorScheme => const ColorScheme.light(
        primary: AppColors.buttonOrange,
        onPrimary: AppColors.textPrimary,
        secondary: AppColors.buttonGreen,
        onSecondary: AppColors.textPrimary,
        tertiary: AppColors.buttonBlue,
        onTertiary: AppColors.textPrimary,
        surface: AppColors.sky,
        onSurface: AppColors.textPrimary,
      );

  /// 텍스트 테마
  static TextTheme get _textTheme => TextTheme(
        displayLarge: GoogleFonts.fredoka(
          fontSize: 56,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        headlineLarge: GoogleFonts.fredoka(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        headlineMedium: GoogleFonts.fredoka(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleLarge: GoogleFonts.fredoka(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
        ),
        labelLarge: GoogleFonts.fredoka(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      );
}
