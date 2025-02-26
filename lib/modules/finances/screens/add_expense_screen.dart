import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendee/modules/auth/providers/auth_provider.dart';
import '../providers/finance_provider.dart'; // Importa el AuthProvider

class AddExpenseScreen extends StatelessWidget {
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();

  AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context); // Obtén el AuthProvider

    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Gasto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Monto'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final amount = double.tryParse(_amountController.text) ?? 0.0;
                final category = _categoryController.text;

                if (amount > 0 && category.isNotEmpty) {
                  if (authProvider.isAuthenticated) {
                    // Si el usuario está autenticado, guarda el gasto
                    await financeProvider.addExpense(
                      userId: authProvider.user!.uid, // Usa el ID del usuario autenticado
                      amount: amount,
                      category: category,
                      date: DateTime.now(),
                    );
                    Navigator.pop(context); // Regresar a la pantalla anterior
                  } else {
                    // Si el usuario no está autenticado, muestra un diálogo
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Iniciar Sesión Requerido'),
                        content: const Text('Debes iniciar sesión para guardar gastos.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Cerrar el diálogo
                              Navigator.pushNamed(context, '/login'); // Redirigir a login
                            },
                            child: const Text('Iniciar Sesión'),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, ingresa un monto y una categoría válidos')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}