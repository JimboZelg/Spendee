import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendee/core/constants/app_routes.dart';
import 'package:spendee/core/theme/text_styles.dart';
import 'package:spendee/core/theme/theme_provider.dart';
import 'package:spendee/modules/auth/providers/auth_provider.dart';
import '../providers/finance_provider.dart';
import '../widgets/finance_summary.dart';
import '../widgets/account_summary.dart';
import '../widgets/recent_transactions.dart';
import '../widgets/balance_chart.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio', style: TextStyles.appBarTitle),
        actions: [
          if (authProvider.isAuthenticated)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  authProvider.userName ?? 'Usuario',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
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
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Personalizar Avatar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.customizeAvatar);
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Historial de Gastos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.statistics);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notificaciones'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.notificationSettings);
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text('Registrarse'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.register);
              },
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Cambiar Tema'),
              onTap: () {
                final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                themeProvider.toggleTheme();
              },
            ),
            if (!authProvider.isAuthenticated) // Mostrar solo si no está autenticado
              ListTile(
                leading: Icon(Icons.login),
                title: Text('Iniciar Sesión'),
                onTap: () {
                  Navigator.pop(context); // Cerrar el drawer
                  Navigator.pushNamed(context, AppRoutes.login); // Navegar a la pantalla de login
                },
              ),
            if (authProvider.isAuthenticated) // Mostrar solo si está autenticado
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Cerrar Sesión'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FinanceSummary(),
              SizedBox(height: 20),
              AccountSummary(),
              SizedBox(height: 20),
              RecentTransactions(),
              SizedBox(height: 20),
              BalanceChart(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addExpense);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}