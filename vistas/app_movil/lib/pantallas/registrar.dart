import 'package:flutter/material.dart';
import 'iniciar_sesion.dart';
import 'verificaciones/verificacion1.dart'; // Asegúrate de que esta importación sea correcta
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  final String tipoCuenta;
  const RegisterScreen({required this.tipoCuenta, super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  String _errorMessage = '';

  Future<void> _registrarUsuario() async {
    final response = await http.post(
      Uri.parse('http://localhost:3500/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'correo': _correoController.text,
        'nombre': _nombreController.text,
        'telefono': _telefonoController.text,
        'tipo': widget.tipoCuenta,
        'contrasena': _contrasenaController.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['success']) {
        _sendemail();
      } else {
        setState(() {
          _errorMessage = responseBody['message'];
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Error en la solicitud. Inténtalo de nuevo.';
      });
    }
  }

  Future<void> _sendemail() async {
    final response = await http.post(
      Uri.parse('http://localhost:3500/api/send-verification-code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _correoController.text,
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['success']) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyPhoneScreen(
              code: responseBody['codigo_verificacion'],
            ),
          ),
        );
      } else {
        setState(() {
          _errorMessage = responseBody['message'];
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Error al enviar el correo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: screenSize.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: const Text(
                'Registrar Cuenta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Luckiest Guy',
                  color: Color(0xFF273BF4),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Ya registró su cuenta? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    child: const Text('Iniciar Sesión', style: TextStyle(color: Color.fromRGBO(41, 87, 194, 1))),
                  ),
                ],
              ),
            ),
            Image.asset('assets/images/foto3.png', height: screenSize.height * 0.3),
            SizedBox(height: screenSize.height * 0.009),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.09),
              child: Text(
                'Ingresa tus datos para continuar usando nuestra aplicación',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: const Color(0xFF192342),
                  fontSize: screenSize.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Correo', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _correoController,
                    decoration: InputDecoration(
                      hintText: 'Ingrese su correo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(198, 212, 255, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.012),
                  const Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _nombreController,
                    decoration: InputDecoration(
                      hintText: 'Ingresar Nombre completo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(198, 212, 255, 1),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.012),
                  const Text('Número de teléfono', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _telefonoController,
                    decoration: InputDecoration(
                      hintText: 'Ingresar Número de teléfono',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(198, 212, 255, 1),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: screenSize.height * 0.012),
                  const Text('Contraseña', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _contrasenaController,
                    decoration: InputDecoration(
                      hintText: '********',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(198, 212, 255, 1),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  Center(
                    child: ElevatedButton(
                      onPressed: _registrarUsuario,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF567DF4),
                        foregroundColor: Colors.white,
                        minimumSize: Size(screenSize.width * 0.9, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Crear Cuenta'),
                    ),
                  ),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
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
