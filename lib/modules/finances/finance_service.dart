import 'package:cloud_firestore/cloud_firestore.dart';

class FinanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Guardar un gasto
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
        'date': Timestamp.fromDate(date),
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
        data['id'] = doc.id; // Agregar el ID del documento
        data['date'] = (data['date'] as Timestamp).toDate(); // Convertir Timestamp a DateTime
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener los gastos: $e');
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