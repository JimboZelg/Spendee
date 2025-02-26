import 'package:flutter/material.dart';

class BudgetProgressBar extends StatelessWidget {
  final double currentAmount;
  final double limit;

  const BudgetProgressBar({super.key, 
    required this.currentAmount,
    required this.limit,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentAmount / limit;

    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          color: progress > 1 ? Colors.red : Colors.green,
        ),
        const SizedBox(height: 5),
        Text(
          '\$${currentAmount.toStringAsFixed(2)} / \$${limit.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}