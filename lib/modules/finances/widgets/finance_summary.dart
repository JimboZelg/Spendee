import 'package:flutter/material.dart';

class FinanceSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Febrero 2025'),
            SizedBox(height: 8.0),
            Text('Ingresos: \$1,600.00'),
            Text('Gastos: \$400.00'),
            Text('Total: \$1,200.00'),
          ],
        ),
      ),
    );
  }
}