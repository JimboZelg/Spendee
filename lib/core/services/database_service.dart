import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spendee/core/services/sync_services.dart';
import 'package:spendee/firebase_options.dart';
import 'connectivity_service.dart';
import 'local_database_service.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ConnectivityService _connectivityService = ConnectivityService();
  final LocalDatabaseService _localDb = LocalDatabaseService();
  final SyncService _syncService = SyncService();

  // Inicializar Firebase
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Habilitar persistencia offline
    _firestore.settings = Settings(persistenceEnabled: true);
  }

  // Guardar un gasto en la base de datos
  Future<void> saveExpense({
    required String userId,
    required double amount,
    required String category,
    required DateTime date,
  }) async {
    try {
      if (await _connectivityService.isConnected()) {
        await _firestore.collection('users').doc(userId).collection('expenses').add({
          'amount': amount,
          'category': category,
          'date': Timestamp.fromDate(date),
        });
      } else {
        await _localDb.saveExpense(
          userId: userId,
          amount: amount,
          category: category,
          date: date,
        );
      }
    } catch (e) {
      throw Exception('Error al guardar el gasto: $e');
    }
  }

  // Obtener todos los gastos de un usuario
  Future<List<Map<String, dynamic>>> getExpenses(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('expenses')
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        // Convertir Timestamp a DateTime
        data['date'] = (data['date'] as Timestamp).toDate();
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener los gastos: $e');
    }
  }

  // Actualizar un gasto existente
  Future<void> updateExpense({
    required String userId,
    required String expenseId,
    required double amount,
    required String category,
    required DateTime date,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('expenses')
          .doc(expenseId)
          .update({
        'amount': amount,
        'category': category,
        'date': Timestamp.fromDate(date),
      });
    } catch (e) {
      throw Exception('Error al actualizar el gasto: $e');
    }
  }

  // Eliminar un gasto
  Future<void> deleteExpense({
    required String userId,
    required String expenseId,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('expenses')
          .doc(expenseId)
          .delete();
    } catch (e) {
      throw Exception('Error al eliminar el gasto: $e');
    }
  }

  // Guardar el nombre de usuario en la base de datos
  Future<void> saveUserName(String userId, String username) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'username': username,
      }, SetOptions(merge: true)); // Usa merge para no sobrescribir otros datos
    } catch (e) {
      throw Exception('Error al guardar el nombre de usuario: $e');
    }
  }

  // Obtener el nombre de usuario desde la base de datos
  Future<String?> getUserName(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.data()?['username'] as String?;
    } catch (e) {
      throw Exception('Error al obtener el nombre de usuario: $e');
    }
  }

  // Guardar un presupuesto en Firestore
  Future<void> saveBudget({
    required String userId,
    required String category,
    required double limit,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).collection('budgets').add({
        'category': category,
        'limit': limit,
        'currentSpent': 0.0, // Inicialmente, el gasto actual es 0
      });
    } catch (e) {
      throw Exception('Error al guardar el presupuesto: $e');
    }
  }

  // Guardar personalización del avatar en Firestore
  Future<void> saveAvatarCustomization({
    required String userId,
    required String clothing,
    required String accessories,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).collection('avatar_customizations').add({
        'clothing': clothing,
        'accessories': accessories,
        'lastUpdated': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Error al guardar la personalización del avatar: $e');
    }
  }

  // Sincronizar datos si hay conexión a internet
  Future<void> syncIfConnected(String userId) async {
    if (await _connectivityService.isConnected()) {
      await _syncService.syncData(userId);
    }
  }
}