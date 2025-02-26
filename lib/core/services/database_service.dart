import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spendee/firebase_options.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Inicializar Firebase (esto ya lo haces en main.dart, pero lo menciono por claridad)
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Guardar un gasto en la base de datos
  Future<void> saveExpense({
    required String userId,
    required double amount,
    required String category,
    required DateTime date,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).collection('expenses').add({
        'amount': amount,
        'category': category,
        'date': Timestamp.fromDate(date), // Firestore usa Timestamp para fechas
      });
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
}