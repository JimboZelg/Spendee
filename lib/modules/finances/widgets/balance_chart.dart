import 'package:flutter/material.dart';

class BalanceChart extends StatelessWidget {
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
              'Balance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            // Aquí puedes agregar un gráfico usando una librería como fl_chart
            Text('Cantidad total que posee: \$1,200.00'),
          ],
        ),
      ),
    );
  }
}