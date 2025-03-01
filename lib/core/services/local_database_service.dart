import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'spendee.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT,
        amount REAL,
        category TEXT,
        date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE budgets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT,
        category TEXT,
        limit REAL,
        currentSpent REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE avatar_customizations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT,
        clothing TEXT,
        accessories TEXT,
        lastUpdated TEXT
      )
    ''');
  }

  // Guardar un gasto en SQLite
  Future<void> saveExpense({
    required String userId,
    required double amount,
    required String category,
    required DateTime date,
  }) async {
    final db = await database;
    await db.insert('expenses', {
      'userId': userId,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
    });
  }

  // Guardar un presupuesto en SQLite
  Future<void> saveBudget({
    required String userId,
    required String category,
    required double limit,
  }) async {
    final db = await database;
    await db.insert('budgets', {
      'userId': userId,
      'category': category,
      'limit': limit,
      'currentSpent': 0.0,
    });
  }

  // Guardar personalización del avatar en SQLite
  Future<void> saveAvatarCustomization({
    required String userId,
    required String clothing,
    required String accessories,
  }) async {
    final db = await database;
    await db.insert('avatar_customizations', {
      'userId': userId,
      'clothing': clothing,
      'accessories': accessories,
      'lastUpdated': DateTime.now().toIso8601String(),
    });
  }

  // Obtener gastos no sincronizados
  Future<List<Map<String, dynamic>>> getUnsyncedExpenses(String userId) async {
    final db = await database;
    return await db.query('expenses', where: 'userId = ?', whereArgs: [userId]);
  }

  // Obtener presupuestos no sincronizados
  Future<List<Map<String, dynamic>>> getUnsyncedBudgets(String userId) async {
    final db = await database;
    return await db.query('budgets', where: 'userId = ?', whereArgs: [userId]);
  }

  // Obtener personalizaciones no sincronizadas
  Future<List<Map<String, dynamic>>> getUnsyncedAvatarCustomizations(String userId) async {
    final db = await database;
    return await db.query('avatar_customizations', where: 'userId = ?', whereArgs: [userId]);
  }

  // Eliminar datos sincronizados
  Future<void> deleteSyncedData(String table, int id) async {
    final db = await database;
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}