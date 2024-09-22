import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_reader/core/utils/colors.dart';

abstract class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.blackGreyish,
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.blackGreyish,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      border: InputBorder.none,
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: AppColors.primary.withOpacity(0.25),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.primary,
      size: 45,
    ),
    textTheme: GoogleFonts.itimTextTheme(
      const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    ),
  );
}
