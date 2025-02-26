import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_provider.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración de Notificaciones')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Notificaciones Habilitadas'),
              value: notificationProvider.notificationsEnabled,
              onChanged: (value) async {
                await notificationProvider.toggleNotifications(value);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await notificationProvider.showNotification(
                  title: 'Prueba de Notificación',
                  body: 'Esta es una notificación de prueba.',
                );
              },
              child: const Text('Mostrar Notificación de Prueba'),
            ),
          ],
        ),
      ),
    );
  }
}