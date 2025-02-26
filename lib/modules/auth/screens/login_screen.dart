import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart'; // Importa el provider de autenticación
import '../widgets/auth_textfield.dart';  // Importa el campo de texto personalizado
import '../widgets/auth_button.dart';     // Importa el botón personalizado

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AuthTextField(
              label: 'Correo Electrónico',
              controller: _emailController,
            ),
            const SizedBox(height: 16),
            AuthTextField(
              label: 'Contraseña',
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            AuthButton(
              text: 'Iniciar Sesión',
              onPressed: () async {
                try {
                  await authProvider.login(
                    _emailController.text,
                    _passwordController.text,
                  );
                  Navigator.pushReplacementNamed(context, '/home');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}