import 'package:flutter/material.dart';

class FinanceTable extends StatelessWidget {
  final List<Map<String, dynamic>> transactions; // Cambiamos expenses por transactions

  const FinanceTable({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Categoría')),
          DataColumn(label: Text('Monto')),
          DataColumn(label: Text('Fecha')),
          DataColumn(label: Text('Tipo')), // Nueva columna para el tipo de transacción
        ],
        rows: transactions.map((transaction) {
          return DataRow(cells: [
            DataCell(Text(transaction['category'])),
            DataCell(Text('\$${transaction['amount'].toStringAsFixed(2)}')),
            DataCell(Text(transaction['date'].toString())),
            DataCell(Text(transaction['isIncome'] ? 'Ingreso' : 'Gasto')), // Nueva celda para el tipo
          ]);
        }).toList(),
      ),
    );
  }
}