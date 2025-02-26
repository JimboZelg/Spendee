import 'package:flutter/material.dart';
import 'package:spendee/core/services/notification_service.dart';

class NotificationProvider with ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  bool _notificationsEnabled = true;

  bool get notificationsEnabled => _notificationsEnabled;

  // Inicializar el servicio de notificaciones
  Future<void> init() async {
    await _notificationService.init();
  }

  // Habilitar o deshabilitar notificaciones
  Future<void> toggleNotifications(bool enabled) async {
    _notificationsEnabled = enabled;
    notifyListeners();
  }

  // Mostrar una notificación
  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    if (_notificationsEnabled) {
      await _notificationService.showNotification(title: title, body: body);
    }
  }

  // Programar una notificación
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    if (_notificationsEnabled) {
      await _notificationService.scheduleNotification(
        title: title,
        body: body,
        scheduledDate: scheduledDate,
      );
    }
  }
}