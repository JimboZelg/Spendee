import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendee/core/constants/app_routes.dart';
import 'package:spendee/core/theme/app_them.dart';
import 'core/theme/theme_provider.dart'; // Importa el ThemeProvider

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Obtén el ThemeProvider

    return MaterialApp(
      title: 'Spendee',
      theme: AppTheme.lightTheme(), // Tema claro
      darkTheme: AppTheme.darkTheme(), // Tema oscuro
      themeMode: themeProvider.themeMode, // Usa el tema seleccionado
      initialRoute: AppRoutes.home,
      routes: AppRoutes.getRoutes(),
    );
  }
}