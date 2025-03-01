import 'package:flutter/material.dart';
import '../modules/auth/screens/login_screen.dart'; // Pantalla de inicio de sesión
import '../modules/auth/screens/register_screen.dart'; // Pantalla de registro
import '../modules/finances/screens/add_expense_screen.dart'; // Pantalla para agregar gastos
import '../modules/finances/screens/budget_screen.dart'; // Pantalla de presupuestos
import '../modules/finances/screens/finance_summary_screen.dart'; // Resumen financiero
import '../modules/finances/screens/statistics_screen.dart'; // Estadísticas
import '../modules/notifications/screens/notification_settings_screen.dart'; // Configuración de notificaciones
import '../modules/avatar/screens/customize_avatar_screen.dart'; // Personalización del avatar

class AppRoutes {
  // Definición de rutas
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String addExpense = '/add-expense';
  static const String budget = '/budget';
  static const String financeSummary = '/finance-summary';
  static const String statistics = '/statistics';
  static const String notificationSettings = '/notification-settings';
  static const String customizeAvatar = '/customize-avatar';

  // Método para obtener las rutas
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginScreen(),
      register: (context) => RegisterScreen(),
      addExpense: (context) => const AddExpenseScreen(),
      budget: (context) => BudgetScreen(),
      financeSummary: (context) => const FinanceSummaryScreen(),
      statistics: (context) => const StatisticsScreen(),
      notificationSettings: (context) => const NotificationSettingsScreen(),
      customizeAvatar: (context) => const CustomizeAvatarScreen(userId: 'userId'), // Cambia 'userId' por el ID del usuario actual
    };
  }
}