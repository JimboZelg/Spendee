import 'package:cloud_firestore/cloud_firestore.dart';

class FinanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Guardar una transacción (gasto o ingreso)
  Future<void> saveTransaction({
    required String userId,
    required double amount,
    required String category,
    required DateTime date,
    required bool isIncome, // Indica si es un ingreso
  }) async {
    try {
      await _firestore.collection('users').doc(userId).collection('transactions').add({
        'amount': amount,
        'category': category,
        'date': Timestamp.fromDate(date),
        'isIncome': isIncome, // Agregar el campo isIncome
      });
    } catch (e) {
      throw Exception('Error al guardar la transacción: $e');
    }
  }

  // Obtener todas las transacciones de un usuario
  Future<List<Map<String, dynamic>>> getTransactions(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .orderBy('date', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Agregar el ID del documento
        data['date'] = (data['date'] as Timestamp).toDate(); // Convertir Timestamp a DateTime
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener las transacciones: $e');
    }
  }

  // Establecer un presupuesto
  Future<void> setBudget({
    required String userId,
    required String category,
    required double limit,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'budgets.$category': limit,
      });
    } catch (e) {
      throw Exception('Error al establecer el presupuesto: $e');
    }
  }

  // Obtener los presupuestos de un usuario
  Future<Map<String, double>> getBudgets(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      return (doc.data()?['budgets'] as Map<String, dynamic>?)?.map((key, value) => MapEntry(key, value.toDouble())) ?? {};
    } catch (e) {
      throw Exception('Error al obtener los presupuestos: $e');
    }
  }
}