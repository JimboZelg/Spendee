import 'package:flutter/material.dart';
import '../../modules/auth/screens/login_screen.dart';
import '../../modules/auth/screens/register_screen.dart';
import '../../modules/finances/screens/add_expense_screen.dart';
import '../../modules/finances/screens/statistics_screen.dart';
import '../../modules/finances/screens/home_screen.dart';
import '../../modules/avatar/screens/customize_avatar_screen.dart';
import '../../modules/notifications/screens/notification_settings_screen.dart';

class AppRoutes {
  // Rutas principales
  static const String login = '/login';
  static const String register = '/register'; // Ruta de registro
  static const String home = '/home';
  static const String addExpense = '/add-expense';
  static const String statistics = '/statistics';
  static const String customizeAvatar = '/customize-avatar';
  static const String notificationSettings = '/notification-settings';

  // Método para obtener las rutas
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginScreen(),
      register: (context) => RegisterScreen(), // Pantalla de registro
      home: (context) => HomeScreen(),
      addExpense: (context) => const AddExpenseScreen(),
      statistics: (context) => const StatisticsScreen(),
      customizeAvatar: (context) => const CustomizeAvatarScreen(userId: 'userId'), // Cambia 'userId' por el ID del usuario actual
      notificationSettings: (context) => const NotificationSettingsScreen(),
    };
  }
}