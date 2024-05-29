import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            // Title with custom font and color
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '¿Buscas un lugar para estacionarte?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Luckiest Guy', // Specify the custom font
                  color: Color(0xFF273BF4), // Custom color
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Updated image path
            Image.asset('assets/images/imagen1.png', height: 300),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Número de Teléfono',
                      hintText: 'Introduce tu número de teléfono',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      hintText: 'Introduce tu contraseña',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Action when pressed
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50), // Button height
                    ),
                    child: const Text('Iniciar Sesión'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Action for creating an account
                    },
                    child: const Text('Crear Cuenta'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Action for password recovery
                    },
                    child: const Text('Recupérala'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
