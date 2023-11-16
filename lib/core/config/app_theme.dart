import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AppThemes {
  static const elevation = 0.0;

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      elevation: elevation,
      backgroundColor: Colors.blueAccent.withOpacity(0.1),
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimaryColor,
      secondary: AppColors.lightSecondaryColor,
      surface: AppColors.lightSurfaceColor,
      background: AppColors.lightBackgroundColor,
      error: AppColors.lightErrorColor,
      onPrimary: AppColors.lightOnPrimaryColor,
      onSecondary: AppColors.lightOnSecondaryColor,
      onSurface: AppColors.lightOnSurfaceColor,
      onBackground: AppColors.lightOnBackgroundColor,
      onError: AppColors.lightOnErrorColor,
      brightness: Brightness.light,
    ),
  );
  static final darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: elevation,
      backgroundColor: Colors.indigoAccent.withOpacity(0.1),
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimaryColor,
      secondary: AppColors.darkSecondaryColor,
      surface: AppColors.darkSurfaceColor,
      background: AppColors.darkBackgroundColor,
      error: AppColors.darkErrorColor,
      onPrimary: AppColors.darkOnPrimaryColor,
      onSecondary: AppColors.darkOnSecondaryColor,
      onSurface: AppColors.darkOnSurfaceColor,
      onBackground: AppColors.darkOnBackgroundColor,
      onError: AppColors.darkOnErrorColor,
      brightness: Brightness.dark,
    ),
  );
}
