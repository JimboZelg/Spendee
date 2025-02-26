import 'package:flutter/material.dart';
import 'package:spendee/modules/avatar/avatar_service.dart';

class AvatarProvider with ChangeNotifier {
  final AvatarService _avatarService = AvatarService();
  Map<String, dynamic> _avatarData = {};

  Map<String, dynamic> get avatarData => _avatarData;

  // Cargar la personalización del avatar
  Future<void> loadAvatar(String userId) async {
    try {
      _avatarData = await _avatarService.loadAvatar(userId) ?? {};
      notifyListeners();
    } catch (e) {
      throw Exception('Error al cargar el avatar: $e');
    }
  }

  // Guardar la personalización del avatar
  Future<void> saveAvatar(String userId, Map<String, dynamic> avatarData) async {
    try {
      await _avatarService.saveAvatar(userId, avatarData);
      _avatarData = avatarData;
      notifyListeners();
    } catch (e) {
      throw Exception('Error al guardar el avatar: $e');
    }
  }
}