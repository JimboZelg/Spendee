import 'package:flutter/material.dart';

class FinanceTable extends StatelessWidget {
  final List<Map<String, dynamic>> expenses;

  const FinanceTable({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Categoría')),
          DataColumn(label: Text('Monto')),
          DataColumn(label: Text('Fecha')),
        ],
        rows: expenses.map((expense) {
          return DataRow(cells: [
            DataCell(Text(expense['category'])),
            DataCell(Text('\$${expense['amount'].toStringAsFixed(2)}')),
            DataCell(Text(expense['date'].toString())),
          ]);
        }).toList(),
      ),
    );
  }
}