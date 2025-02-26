import 'package:flutter/material.dart';
import '../finance_service.dart';

class FinanceProvider with ChangeNotifier {
  final FinanceService _financeService = FinanceService();
  List<Map<String, dynamic>> _expenses = [];
  Map<String, double> _budgets = {};

  List<Map<String, dynamic>> get expenses => _expenses;
  Map<String, double> get budgets => _budgets;

  // Cargar gastos
  Future<void> loadExpenses(String userId) async {
    try {
      _expenses = await _financeService.getExpenses(userId);
      notifyListeners();
    } catch (e) {
      throw Exception('Error al cargar los gastos: $e');
    }
  }

  // Agregar un gasto
  Future<void> addExpense({
    required String userId,
    required double amount,
    required String category,
    required DateTime date,
  }) async {
    try {
      await _financeService.saveExpense(
        userId: userId,
        amount: amount,
        category: category,
        date: date,
      );
      await loadExpenses(userId); // Recargar los gastos
    } catch (e) {
      throw Exception('Error al agregar el gasto: $e');
    }
  }

  // Establecer un presupuesto
  Future<void> setBudget({
    required String userId,
    required String category,
    required double limit,
  }) async {
    try {
      await _financeService.setBudget(
        userId: userId,
        category: category,
        limit: limit,
      );
      _budgets = await _financeService.getBudgets(userId);
      notifyListeners();
    } catch (e) {
      throw Exception('Error al establecer el presupuesto: $e');
    }
  }
}