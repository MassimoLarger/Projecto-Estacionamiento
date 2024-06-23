import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'codigo_verificado_contra.dart';
import 'codigo_erroneo_contra.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyPhoneContraScreen extends StatefulWidget {
  final String email;  // Campo para almacenar el correo electrónico
  const VerifyPhoneContraScreen({super.key, required this.email});

  @override
  VerifyPhoneContraScreenState createState() => VerifyPhoneContraScreenState();
}

class VerifyPhoneContraScreenState extends State<VerifyPhoneContraScreen> {
  final TextEditingController _pinController = TextEditingController();

  Future<void> verificarCodigo(String codigo) async {
    try {
      final response = await http.post(
        Uri.parse('https://localhost:3500/api/verify-code'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': widget.email,
          'code': codigo,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success']) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CodigoVerificadoContraWidget()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CodigoVerificadoErrorContraWidget()),
          );
        }
      } else {
        throw Exception('Failed to verify code');
      }
    } catch (error) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CodigoVerificadoErrorContraWidget()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Procesar el correo electrónico para mostrar solo una parte
    String processedEmail = widget.email.replaceAll(RegExp(r'(?<=.{2}).(?=[^@]*?.@)'), '*');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleTextStyle: const TextStyle(color: Colors.blue, fontSize: 20),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),  // Padding relativo al ancho de la pantalla
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.02),
              Image.asset('assets/images/logo2.png', width: screenWidth * 0.6), // Imagen escalada según ancho de pantalla
              SizedBox(height: screenHeight * 0.05),
              Text(
                "Recuperación de contraseña",
                style: TextStyle(fontSize: screenWidth * 0.06, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Enviamos un código de verificación a $processedEmail",
                style: TextStyle(fontSize: screenWidth * 0.045, fontFamily: 'Lato', color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Ingrese su código aquí",
                style: TextStyle(fontSize: screenWidth * 0.045, fontFamily: 'Lato', color: Colors.black),
              ),
              SizedBox(height: screenHeight * 0.03),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _pinController,
                onChanged: (String value) {},
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: screenWidth * 0.12, // Altura de los campos proporcional al ancho
                  fieldWidth: screenWidth * 0.1, // Ancho de los campos proporcional al ancho
                  activeFillColor: Colors.blue[50],
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: screenHeight * 0.21),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: screenHeight * 0.02),
                ),
                onPressed: () => verificarCodigo(_pinController.text),
                child: const Text("Verificar Ahora"),
              )
            ],
          ),
        ),
      ),
    );
  }
}