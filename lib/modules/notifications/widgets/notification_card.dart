import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final DateTime date;

  const NotificationCard({super.key, 
    required this.title,
    required this.body,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(body),
        trailing: Text('${date.hour}:${date.minute}'),
      ),
    );
  }
}