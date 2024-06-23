import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'codigo_verificado.dart';
import 'codigo_erroneo.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String code;
  const VerifyPhoneScreen({required this.code, super.key});

  @override
  VerifyPhoneScreenState createState() => VerifyPhoneScreenState();
}

class VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController _pinController = TextEditingController();
  String _errorMessage = '';

  Future<void> verificarCodigo() async {
    final response = await http.post(
      Uri.parse('http://localhost:3500/api/verify-code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'code': widget.code,
        'codigo_verificacion': _pinController.text,
      }),
    );

    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseBody['success']) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CodigoVerificadoWidget()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CodigoVerificadoErrorWidget()),
        );
      }
    } else {
      setState(() {
        _errorMessage = 'Error en la solicitud. Inténtalo de nuevo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.02),
              Image.asset('assets/images/logo2.png', width: screenWidth * 0.6),
              SizedBox(height: screenHeight * 0.05),
              Text(
                "Verifique su correo",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Ingrese su código aquí",
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontFamily: 'Lato',
                  color: Colors.black,
                ),
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
                  fieldHeight: screenWidth * 0.12,
                  fieldWidth: screenWidth * 0.1,
                  activeFillColor: Colors.blue[50],
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: screenHeight * 0.28),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: screenHeight * 0.02),
                ),
                onPressed: verificarCodigo,
                child: const Text("Verificar Ahora"),
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
      ),
    );
  }
}