import 'package:flutter/material.dart';
import 'verificaciones/contrasena_erronea.dart';
import 'verificaciones/contrasena_verificada.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _verifyPasswordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _showConfirmationDialog(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3500/api/actualizar_contrasena'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': widget.email,
          'newPassword': _newPasswordController.text,
          'newPassword_verify': _verifyPasswordController.text,
        }),
      );

      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseBody['success']) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ContrasenaVerificadaWidget()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ContrasenaErrorWidget()),
          );
        }
      } else {
        setState(() {
          _errorMessage = responseBody['message'] ?? 'Error desconocido';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al conectar con el servidor.';
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo3.png',
              height: screenHeight * 0.25,
            ),
            const SizedBox(height: 20),
            const Text(
              'Reestablecer contraseña',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontFamily: 'Lato', fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Introduce tu nueva contraseña',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'Lato'),
            ),
            SizedBox(height: screenHeight * 0.02),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nueva contraseña',
                style: TextStyle(fontSize: 16, fontFamily: 'Lato', fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Ingresa tu nueva contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(198, 212, 255, 1),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Confirmar contraseña',
                style: TextStyle(fontSize: 16, fontFamily: 'Lato', fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            TextField(
              controller: _verifyPasswordController,
              decoration: InputDecoration(
                hintText: 'Confirma tu nueva contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(198, 212, 255, 1),
              ),
              obscureText: true,
            ),
            SizedBox(height: screenHeight * 0.02),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Center(
              child: ElevatedButton(
                onPressed: () => _showConfirmationDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  minimumSize: Size(screenWidth * 0.9, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                ),
                child: const Text(
                  'Confirmar nueva contraseña',
                  style: TextStyle(fontSize: 16, fontFamily: 'Lato', color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}