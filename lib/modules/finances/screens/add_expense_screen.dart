import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import '/../modules/auth/providers/auth_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  String _transactionType = 'Gasto'; // Estado para el tipo de transacción

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Transacción')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Selector de tipo de transacción
            DropdownButton<String>(
              value: _transactionType,
              onChanged: (String? newValue) {
                setState(() {
                  _transactionType = newValue!; // Actualizar el estado
                });
              },
              items: <String>['Gasto', 'Ingreso']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
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
                final isIncome = _transactionType == 'Ingreso'; // Determinar si es un ingreso

                if (amount > 0 && category.isNotEmpty) {
                  try {
                    await financeProvider.addTransaction(
                      amount: amount,
                      category: category,
                      date: DateTime.now(),
                      isIncome: isIncome,
                      userId: authProvider.isAuthenticated ? authProvider.user!.uid : null,
                    );
                    Navigator.pop(context); // Regresar a la pantalla anterior
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al agregar la transacción: $e')),
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