import 'package:cloud_firestore/cloud_firestore.dart';

class AvatarService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Guardar la personalización del avatar
  Future<void> saveAvatar(String userId, Map<String, dynamic> avatarData) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'avatar': avatarData,
      });
    } catch (e) {
      throw Exception('Error al guardar el avatar: $e');
    }
  }

  // Cargar la personalización del avatar
  Future<Map<String, dynamic>?> loadAvatar(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.data()?['avatar'] as Map<String, dynamic>?;
    } catch (e) {
      throw Exception('Error al cargar el avatar: $e');
    }
  }
}