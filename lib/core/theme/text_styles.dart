import 'package:flutter/material.dart';
import '../constants/app_colors.dart'; // Importa los colores de la aplicación

class TextStyles {
  // Estilos de texto para la barra de aplicaciones
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Estilos de texto para el cuerpo del texto
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  // Estilos de texto para títulos
  static const TextStyle titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Estilos de texto para botones
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Estilos de texto para mensajes de error
  static const TextStyle errorText = TextStyle(
    fontSize: 14,
    color: AppColors.errorColor,
  );
}