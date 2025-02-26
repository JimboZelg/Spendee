import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_textfield.dart';
import '../widgets/auth_button.dart';

class RegisterScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  RegisterScreen({super.key}); // Controlador para el nombre de usuario

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AuthTextField(
              label: 'Nombre de Usuario',
              controller: _usernameController,
            ),
            const SizedBox(height: 16),
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
            AuthTextField(
              label: 'Confirmar Contraseña',
              controller: _confirmPasswordController,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            AuthButton(
              text: 'Registrarse',
              onPressed: () async {
                final username = _usernameController.text;
                final email = _emailController.text;
                final password = _passwordController.text;
                final confirmPassword = _confirmPasswordController.text;

                if (password != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Las contraseñas no coinciden')),
                  );
                  return;
                }

                try {
                  await authProvider.register(email, password, username); // Pasa el nombre de usuario
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