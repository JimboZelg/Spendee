import 'package:flutter/material.dart';
import '../constants/app_colors.dart'; // Importa app_colors.dart desde la carpeta constants
import 'text_styles.dart'; // Importa text_styles.dart desde la misma carpeta

class AppTheme {
  // Tema Claro
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
      ),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: TextStyles.appBarTitle,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyles.bodyLarge,
        bodyMedium: TextStyles.bodyMedium,
        titleLarge: TextStyles.titleLarge,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }

  // Tema Oscuro
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
      ),
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        titleTextStyle: TextStyles.appBarTitle.copyWith(color: Colors.white),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyles.bodyLarge.copyWith(color: Colors.white),
        bodyMedium: TextStyles.bodyMedium.copyWith(color: Colors.white),
        titleLarge: TextStyles.titleLarge.copyWith(color: Colors.white),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}