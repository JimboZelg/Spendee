import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final Map<String, dynamic> expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${expense['category']}: \$${expense['amount'].toStringAsFixed(2)}'),
        subtitle: Text('Fecha: ${expense['date'].toString()}'),
      ),
    );
  }
}