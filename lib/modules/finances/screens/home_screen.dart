import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendee/core/constants/app_routes.dart';
import 'package:spendee/core/theme/text_styles.dart';
import 'package:spendee/core/theme/theme_provider.dart';
import 'package:spendee/modules/auth/providers/auth_provider.dart';
import '../providers/finance_provider.dart';
import '/../../modules/auth/providers/auth_provider.dart'; // Importa el AuthProvider

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context); // Obtén el AuthProvider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio', style: TextStyles.appBarTitle),
        actions: [
          if (authProvider.isAuthenticated) // Solo muestra si el usuario está autenticado
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  authProvider.userName ?? 'Usuario', // Muestra el nombre del usuario
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Spendee',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Personalizar Avatar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.customizeAvatar);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Historial de Gastos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.statistics);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificaciones'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.notificationSettings);
              },
            ),
            ListTile(
              leading: const Icon(Icons.app_registration),
              title: const Text('Registrarse'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.register);
              },
            ),
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Cambiar Tema'),
              onTap: () {
                final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                themeProvider.toggleTheme();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                final authProvider = Provider.of<AuthProvider>(context, listen: false);
                authProvider.logout();
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Bienvenido a Spendee',
              style: TextStyles.titleLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.addExpense);
              },
              child: const Text('Agregar Gasto'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.statistics);
              },
              child: const Text('Ver Estadísticas'),
            ),
          ],
        ),
      ),
    );
  }
}