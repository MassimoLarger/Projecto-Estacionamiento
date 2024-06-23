import 'package:flutter/material.dart';
import 'verificaciones/verificacion2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RecuperarContraScreen extends StatelessWidget {
  RecuperarContraScreen({super.key});

  // Controller for the email input field.
  final TextEditingController emailController = TextEditingController();

  Future<void> sendVerificationEmail(String email) async {
    final response = await http.post(
      Uri.parse('http://localhost:3500/api/send-verification-code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      print('Correo enviado');
    } else {
      print('Error al enviar el correo');
    }
  }

  void _showConfirmationDialog(BuildContext context, String email) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Process the email to display partially masked.
    String processedEmail = email.replaceRange(3, email.indexOf('@'), '****');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Container(
                width: width * 0.2,
                height: width * 0.2,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(43, 220, 61, 1),
                ),
                child: const Center(
                  child: Icon(Icons.check, size: 60, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
                child: Text(
                  "Enviamos un correo a $processedEmail.\nRevisa tu bandeja de entrada y sigue las instrucciones para continuar con la recuperación de la contraseña.",
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Cerrar el diálogo primero
                    Navigator.of(context).pop();

                    // Navegar a la pantalla de verificación
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => VerifyPhoneContraScreen(email: email) // Pasa el email aquí
                        )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 15),
                  ),
                  child: const Text("OK", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        );
      },
    );
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
                    controller: emailController,
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
                      await sendVerificationEmail(emailController.text);
                      _showConfirmationDialog(context, emailController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF567DF4),
                      foregroundColor: Colors.white,
                      minimumSize: Size(screenSize.width * 0.90, 50),
                    ),
                    child: const Text('Enviar Correo'),
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