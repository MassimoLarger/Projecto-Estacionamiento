import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tipo_de_cuenta.dart';
import 'recuperar_contrasena.dart';
import 'movilizacion.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  String? _errorMessage;

  Future<void> _iniciarSesion() async {
    setState(() {
      _errorMessage = null; // Resetea el mensaje de error
    });

    try {
      final response = await http.post(
        Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'correo': _correoController.text,
          'contrasena': _contrasenaController.text,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody['success']) {
          final String userId = responseBody['userId'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarSelectionWidget(userId: userId),
            ),
          );
        } else {
          // Usuario no encontrado, muestra mensaje de error
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
        _errorMessage = 'Error en la solicitud. Inténtalo de nuevo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: screenSize.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: const Text(
                '¿Buscas un lugar para estacionarte?',
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
                'Inicie sesión o regístrese en su cuenta de la aplicación Parking Ulagos',
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
                    controller: _correoController,
                    decoration: InputDecoration(
                      hintText: 'Introduzca su correo electrónico',
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
                  const Text('Contraseña', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _contrasenaController,
                    decoration: InputDecoration(
                      hintText: 'Introduzca su contraseña',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(198, 212, 255, 1),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _iniciarSesion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF567DF4),
                      foregroundColor: Colors.white,
                      minimumSize: Size(screenSize.width * 0.90, 50),
                    ),
                    child: const Text('Iniciar Sesión'),
                  ),
                  const SizedBox(height: 16),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: '¿No tienes cuenta? ',
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Crear Cuenta',
                            style: const TextStyle(
                              color: Color.fromRGBO(41, 87, 194, 1),
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const TipodecuentaWidget()));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: '¿Olvidaste la contraseña? ',
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Recupérala',
                            style: const TextStyle(
                              color: Color.fromRGBO(41, 87, 194, 1),
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RecuperarContraScreen()));
                              },
                          ),
                        ],
                      ),
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
