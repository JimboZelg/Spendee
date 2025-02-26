import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FinanceChart extends StatelessWidget {
  final List<Map<String, dynamic>> expenses;

  const FinanceChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> categoryTotals = {};

    for (var expense in expenses) {
      final category = expense['category'];
      final amount = expense['amount'] as double;
      categoryTotals[category] = (categoryTotals[category] ?? 0) + amount;
    }

    final List<PieChartSectionData> pieChartSections = categoryTotals.entries.map((entry) {
      return PieChartSectionData(
        color: Colors.primaries[categoryTotals.keys.toList().indexOf(entry.key) % Colors.primaries.length],
        value: entry.value,
        title: '\$${entry.value.toStringAsFixed(2)}',
        radius: 100,
      );
    }).toList();

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: pieChartSections,
        ),
      ),
    );
  }
}