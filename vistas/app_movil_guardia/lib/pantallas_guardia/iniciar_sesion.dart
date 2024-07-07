import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'sedes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://your-api-url/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'correo': _correoController.text,
        'contrasena': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success']) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GuardiaScreen(userId: responseData['userId']),
          ),
        );
      } else {
        setState(() {
          _errorMessage = responseData['message'];
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Error en la solicitud. Por favor, inténtalo de nuevo.';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: screenSize.width * 0.05),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bienvenidos a Parking APP\nAdmin Ulagos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width * 0.06,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              Text(
                'Ingresa con tu cuenta y utiliza Parking APP Admin Ulagos',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width * 0.03,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Correo',
                  style: TextStyle(fontSize: screenSize.width * 0.035, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              TextField(
                controller: _correoController,
                decoration: InputDecoration(
                  hintText: 'example@ulagos.cl',
                  prefixIcon: const Icon(Icons.account_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Color(0xFFF3F6FF), width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF3F6FF),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contraseña',
                  style: TextStyle(fontSize: screenSize.width * 0.035, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Introduce tu contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Color(0xFFF3F6FF), width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF3F6FF),
                ),
                obscureText: true,
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              SizedBox(height: screenSize.height * 0.35),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  minimumSize: Size(screenSize.width * 0.90, 50),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text('Iniciar Sesión', style: TextStyle(color: Colors.white, fontSize: screenSize.width * 0.04)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}