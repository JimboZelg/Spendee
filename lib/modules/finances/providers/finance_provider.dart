import 'package:flutter/material.dart'; 
import 'package:hive_ce/hive.dart';// Importa Hive CE
import '../finance_service.dart';

class FinanceProvider with ChangeNotifier {
  final FinanceService _financeService = FinanceService();
  List<Map<String, dynamic>> _transactions = []; // Cambiamos _expenses por _transactions
  Map<String, double> _budgets = {};

  List<Map<String, dynamic>> get transactions => _transactions;
  Map<String, double> get budgets => _budgets;

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
      _budgets = await _financeService.getBudgets(userId); // Recargar los presupuestos
      notifyListeners(); // Notificar a los listeners
    } catch (e) {
      throw Exception('Error al establecer el presupuesto: $e');
    }
  }

  // Cargar transacciones
  Future<void> loadTransactions(String? userId) async {
    try {
      if (userId != null) {
        // Cargar transacciones desde la base de datos remota si el usuario está autenticado
        _transactions = await _financeService.getTransactions(userId);
      } else {
        // Cargar transacciones locales si el usuario no está autenticado
        _transactions = _getLocalTransactions();
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Error al cargar las transacciones: $e');
    }
  }

  // Agregar una transacción (gasto o ingreso)
  Future<void> addTransaction({
    required double amount,
    required String category,
    required DateTime date,
    required bool isIncome, // Indica si es un ingreso
    String? userId, // userId es opcional
  }) async {
    try {
      if (userId != null) {
        // Guardar en la base de datos remota
        await _financeService.saveTransaction(
          userId: userId,
          amount: amount,
          category: category,
          date: date,
          isIncome: isIncome,
        );
      } else {
        // Guardar localmente
        _saveTransactionToLocalDatabase(amount, category, date, isIncome);
      }
      await loadTransactions(userId); // Recargar las transacciones
    } catch (e) {
      throw Exception('Error al agregar la transacción: $e');
    }
  }

  // Guardar transacción localmente usando Hive CE
  void _saveTransactionToLocalDatabase(double amount, String category, DateTime date, bool isIncome) {
    final transactionBox = Hive.box('transactions');
    transactionBox.add({
      'amount': amount,
      'category': category,
      'date': date.toString(),
      'isIncome': isIncome,
    });
  }

  // Obtener transacciones locales usando Hive CE
  List<Map<String, dynamic>> _getLocalTransactions() {
    final transactionBox = Hive.box('transactions');
    return transactionBox.values.map((transaction) {
      return {
        'amount': transaction['amount'],
        'category': transaction['category'],
        'date': DateTime.parse(transaction['date']),
        'isIncome': transaction['isIncome'],
      };
    }).toList();
  }

  // Sincronizar transacciones locales con la base de datos remota
  Future<void> syncTransactions(String userId) async {
    try {
      final localTransactions = _getLocalTransactions();
      for (final transaction in localTransactions) {
        await _financeService.saveTransaction(
          userId: userId,
          amount: transaction['amount'],
          category: transaction['category'],
          date: transaction['date'],
          isIncome: transaction['isIncome'],
        );
      }
      // Limpiar las transacciones locales después de sincronizar
      final transactionBox = Hive.box('transactions');
      transactionBox.clear();
      await loadTransactions(userId); // Recargar las transacciones
    } catch (e) {
      throw Exception('Error al sincronizar las transacciones: $e');
    }
  }
}