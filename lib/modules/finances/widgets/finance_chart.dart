import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FinanceChart extends StatelessWidget {
  final List<Map<String, dynamic>> transactions; // Cambiamos expenses por transactions

  const FinanceChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // Calcular totales por categoría para gastos e ingresos
    final Map<String, double> expenseTotals = {};
    final Map<String, double> incomeTotals = {};

    for (var transaction in transactions) {
      final category = transaction['category'];
      final amount = transaction['amount'] as double;
      final isIncome = transaction['isIncome'] as bool;

      if (isIncome) {
        incomeTotals[category] = (incomeTotals[category] ?? 0) + amount;
      } else {
        expenseTotals[category] = (expenseTotals[category] ?? 0) + amount;
      }
    }

    // Crear secciones del gráfico para gastos
    final List<PieChartSectionData> expenseSections = expenseTotals.entries.map((entry) {
      return PieChartSectionData(
        color: Colors.redAccent.withOpacity(0.6),
        value: entry.value,
        title: '\$${entry.value.toStringAsFixed(2)}',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    // Crear secciones del gráfico para ingresos
    final List<PieChartSectionData> incomeSections = incomeTotals.entries.map((entry) {
      return PieChartSectionData(
        color: Colors.greenAccent.withOpacity(0.6),
        value: entry.value,
        title: '\$${entry.value.toStringAsFixed(2)}',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    // Combinar secciones de gastos e ingresos
    final List<PieChartSectionData> pieChartSections = [...expenseSections, ...incomeSections];

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: pieChartSections,
          centerSpaceRadius: 40,
          sectionsSpace: 2,
        ),
      ),
    );
  }
}