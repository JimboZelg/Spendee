import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';

class BudgetScreen extends StatelessWidget {
  final _categoryController = TextEditingController();
  final _limitController = TextEditingController();

  BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Presupuestos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
            TextField(
              controller: _limitController,
              decoration: const InputDecoration(labelText: 'Límite'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final category = _categoryController.text;
                final limit = double.tryParse(_limitController.text) ?? 0.0;

                if (category.isNotEmpty && limit > 0) {
                  await financeProvider.setBudget(
                    userId: 'userId', // Cambia por el ID del usuario actual
                    category: category,
                    limit: limit,
                  );
                  _categoryController.clear();
                  _limitController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, ingresa una categoría y un límite válidos')),
                  );
                }
              },
              child: const Text('Establecer Presupuesto'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: financeProvider.budgets.length,
                itemBuilder: (context, index) {
                  final category = financeProvider.budgets.keys.elementAt(index);
                  final limit = financeProvider.budgets[category];
                  return ListTile(
                    title: Text(category),
                    subtitle: Text('Límite: \$${limit?.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}