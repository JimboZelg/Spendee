import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendee/core/constants/app_routes.dart';
import 'package:spendee/core/theme/text_styles.dart';
import 'package:spendee/core/theme/theme_provider.dart';
import 'package:spendee/modules/auth/providers/auth_provider.dart';
import '../providers/finance_provider.dart';
import '../widgets/finance_summary.dart'; // Importa el nuevo widget
import '../widgets/account_summary.dart'; // Importa el nuevo widget
import '../widgets/recent_transactions.dart'; // Importa el nuevo widget
import '../widgets/balance_chart.dart'; // Importa el nuevo widget

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    // Calcular total de gastos e ingresos
    double totalExpenses = financeProvider.transactions
        .where((transaction) => !transaction['isIncome'])
        .fold(0, (sum, transaction) => sum + transaction['amount']);

    double totalIncome = financeProvider.transactions
        .where((transaction) => transaction['isIncome'])
        .fold(0, (sum, transaction) => sum + transaction['amount']);

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
            if (authProvider.isAuthenticated)
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
              // Card de Gastos Totales
              Card(
                child: ListTile(
                  title: Text('Gastos Totales', style: TextStyles.bodyMedium),
                  subtitle: Text(
                    '\$${totalExpenses.toStringAsFixed(2)}',
                    style: TextStyles.bodyLarge,
                  ),
                  trailing: Icon(Icons.money_off, color: Colors.red),
                ),
              ),
              SizedBox(height: 10),
              // Card de Ingresos Totales
              Card(
                child: ListTile(
                  title: Text('Ingresos Totales', style: TextStyles.bodyMedium),
                  subtitle: Text(
                    '\$${totalIncome.toStringAsFixed(2)}',
                    style: TextStyles.bodyLarge,
                  ),
                  trailing: Icon(Icons.attach_money, color: Colors.green),
                ),
              ),
              SizedBox(height: 20),
              FinanceSummary(), // Nuevo widget
              SizedBox(height: 20),
              AccountSummary(), // Nuevo widget
              SizedBox(height: 20),
              RecentTransactions(), // Nuevo widget
              SizedBox(height: 20),
              BalanceChart(), // Nuevo widget
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