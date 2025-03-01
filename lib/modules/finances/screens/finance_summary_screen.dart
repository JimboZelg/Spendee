import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import '../widgets/finance_chart.dart';

class FinanceSummaryScreen extends StatelessWidget {
  const FinanceSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    // Calcular total de gastos e ingresos
    double totalExpenses = financeProvider.transactions
        .where((transaction) => !transaction['isIncome'])
        .fold(0.0, (sum, transaction) => sum + (transaction['amount'] as double));

    double totalIncome = financeProvider.transactions
        .where((transaction) => transaction['isIncome'])
        .fold(0.0, (sum, transaction) => sum + (transaction['amount'] as double));

    return Scaffold(
      appBar: AppBar(title: const Text('Resumen Financiero')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FinanceChart(transactions: financeProvider.transactions),
            const SizedBox(height: 20),
            Text(
              'Gastos Totales: \$${totalExpenses.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Ingresos Totales: \$${totalIncome.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}