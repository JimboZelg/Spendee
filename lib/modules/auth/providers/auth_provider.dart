import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendee/core/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  String? _userName; // Nueva propiedad para el nombre de usuario

  User? get user => _user;
  String? get userName => _userName; // Getter para el nombre de usuario

  bool get isAuthenticated => _user != null;

  // Iniciar sesión
  Future<void> login(String email, String password) async {
    try {
      _user = await _authService.login(email, password);
      // Aquí puedes cargar el nombre de usuario desde la base de datos si es necesario
      _userName = _user?.email; // Usamos el correo como nombre de usuario por defecto
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