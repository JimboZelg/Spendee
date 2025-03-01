import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendee/core/services/auth_service.dart';
import 'package:spendee/core/services/database_service.dart';// Importa el servicio de base de datos

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService(); // Servicio de base de datos
  User? _user;
  String? _userName; // Propiedad para el nombre de usuario

  User? get user => _user;
  String? get userName => _userName;

  bool get isAuthenticated => _user != null;

  // Iniciar sesión
  Future<void> login(String email, String password) async {
    try {
      _user = await _authService.login(email, password);
      // Cargar el nombre de usuario desde la base de datos
      _userName = await _databaseService.getUserName(_user!.uid);
      notifyListeners();
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  // Registrar un nuevo usuario
  Future<void> register(String email, String password, String username) async {
    try {
      _user = await _authService.register(email, password);
      _userName = username; // Guarda el nombre de usuario
      // Guardar el nombre de usuario en la base de datos
      await _databaseService.saveUserName(_user!.uid, username);
      notifyListeners();
    } catch (e) {
      throw Exception('Error al registrar: $e');
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    try {
      await _authService.logout();
      _user = null;
      _userName = null; // Limpia el nombre de usuario al cerrar sesión
      notifyListeners();
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }
}