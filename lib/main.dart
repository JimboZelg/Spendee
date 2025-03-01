import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';  // Importa Hive CE
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa firebase_core
import 'app.dart'; // Importa el archivo app.dart
import 'modules/notifications/providers/notification_provider.dart';
import 'modules/auth/providers/auth_provider.dart';
import 'modules/finances/providers/finance_provider.dart';
import 'modules/avatar/providers/avatar_provider.dart';
import 'core/theme/theme_provider.dart';

void main() async {
  // Asegura que Flutter esté inicializado
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase
  await Firebase.initializeApp();

  // Configuración de Firestore
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

  // Inicializar Hive CE
  await Hive.initFlutter(); // Inicializa Hive CE
  await Hive.openBox('transactions'); // Abre la caja de transacciones

  // Inicializar servicios globales
  final notificationProvider = NotificationProvider();
  await notificationProvider.init();

  // Ejecutar la aplicación
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