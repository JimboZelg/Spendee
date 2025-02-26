import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa firebase_core
import 'app.dart'; // Importa el archivo app.dart
import 'modules/notifications/providers/notification_provider.dart';
import 'modules/auth/providers/auth_provider.dart';
import 'modules/finances/providers/finance_provider.dart';
import 'modules/avatar/providers/avatar_provider.dart';
import 'core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que Flutter esté inicializado

  // Inicializar Firebase
  await Firebase.initializeApp();

  // Inicializar servicios globales
  final notificationProvider = NotificationProvider();
  await notificationProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => notificationProvider),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FinanceProvider()),
        ChangeNotifierProvider(create: (_) => AvatarProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(), // MyApp está definido en app.dart
    ),
  );
}