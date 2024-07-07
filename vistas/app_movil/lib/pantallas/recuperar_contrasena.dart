import 'package:flutter/material.dart';
import 'verificaciones/verificacion2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecuperarContraScreen extends StatefulWidget {
  const RecuperarContraScreen({super.key});

  @override
  RecuperarContraScreenState createState() => RecuperarContraScreenState();
}

class RecuperarContraScreenState extends State<RecuperarContraScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage;

  Future<void> _sendVerificationEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('http://proyecto-estacionamiento-dy1e.onrender.com/api/send-verification-code'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text, // Usar el parámetro 'email' pasado a la función
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success']) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VerifyPhoneContraScreen(
                email: responseBody['userId'],
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
          _errorMessage = 'Error en la solicitud. Inténtalo de nuevo.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al enviar el correo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: screenSize.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: const Text(
                'Recuperar contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Luckiest Guy',
                  color: Color(0xFF273BF4),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset('assets/images/inicio.png', height: screenSize.height * 0.3),
            SizedBox(height: screenSize.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Text(
                'Ingresa tu correo electrónico para recuperar tu contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: const Color(0xFF192342),
                  fontSize: screenSize.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Correo Electrónico', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Ej: example@gmail.com',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(198, 212, 255, 1),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _sendVerificationEmail(_emailController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF567DF4),
                      foregroundColor: Colors.white,
                      minimumSize: Size(screenSize.width * 0.90, 50),
                    ),
                    child: const Text('Enviar Correo'),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        _errorMessage!,
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