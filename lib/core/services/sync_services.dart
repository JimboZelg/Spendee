import 'package:cloud_firestore/cloud_firestore.dart';
import 'local_database_service.dart';

class SyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocalDatabaseService _localDb = LocalDatabaseService();

  Future<void> syncData(String userId) async {
    // Sincronizar gastos
    final unsyncedExpenses = await _localDb.getUnsyncedExpenses(userId);
    for (var expense in unsyncedExpenses) {
      await _firestore.collection('users').doc(userId).collection('expenses').add({
        'amount': expense['amount'],
        'category': expense['category'],
        'date': Timestamp.fromDate(DateTime.parse(expense['date'])),
      });
      await _localDb.deleteSyncedData('expenses', expense['id'] as int);
    }

    // Sincronizar presupuestos
    final unsyncedBudgets = await _localDb.getUnsyncedBudgets(userId);
    for (var budget in unsyncedBudgets) {
      await _firestore.collection('users').doc(userId).collection('budgets').add({
        'category': budget['category'],
        'limit': budget['limit'],
        'currentSpent': budget['currentSpent'],
      });
      await _localDb.deleteSyncedData('budgets', budget['id'] as int);
    }

    // Sincronizar personalizaciones del avatar
    final unsyncedCustomizations = await _localDb.getUnsyncedAvatarCustomizations(userId);
    for (var customization in unsyncedCustomizations) {
      await _firestore.collection('users').doc(userId).collection('avatar_customizations').add({
        'clothing': customization['clothing'],
        'accessories': customization['accessories'],
        'lastUpdated': Timestamp.fromDate(DateTime.parse(customization['lastUpdated'])),
      });
      await _localDb.deleteSyncedData('avatar_customizations', customization['id'] as int);
    }
  }
}