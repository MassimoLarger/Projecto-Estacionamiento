import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../iniciar_sesion.dart';

class CodigoVerificadoContraWidget extends StatefulWidget {
  final String email;
  final String code;

  const CodigoVerificadoContraWidget({Key? key, required this.email, required this.code}) : super(key: key);

  @override
  CodigoVerificadoContraWidgetState createState() => CodigoVerificadoContraWidgetState();
}

class CodigoVerificadoContraWidgetState extends State<CodigoVerificadoContraWidget> {

  @override
  void initState() {
    super.initState();
    // Llamar a la función para actualizar la contraseña después de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      // Aquí enviamos la solicitud para actualizar la contraseña
      updatePassword(widget.email, 'nueva_contraseña');
    });
  }

  Future<void> updatePassword(String email, String newPassword) async {
    final String apiUrl = 'http://localhost:3500/api/actualizar_contraseña'; // URL de tu servidor Express

    // Datos para enviar al servidor
    final Map<String, dynamic> requestBody = {
      'email': email,
      'newPassword': newPassword,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success']) {
          // Contraseña actualizada exitosamente
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Éxito'),
                content: Text(responseBody['message']),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Usuario no encontrado u otro error
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(responseBody['message']),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        throw Exception('Error al actualizar la contraseña');
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error al conectar con el servidor'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Usamos MediaQuery para obtener el tamaño de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: screenWidth, // Se ajusta al ancho de la pantalla
        height: screenHeight, // Se ajusta a la altura de la pantalla
        decoration: const BoxDecoration(
          color: Color.fromRGBO(86, 125, 244, 1),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.1), // 10% de la altura de la pantalla
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenWidth * 0.4, // 40% del ancho de la pantalla
                height: screenWidth * 0.4, // Hace el círculo siempre proporcional al ancho
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(43, 220, 61, 1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    size: 100,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05), // 5% de la altura de la pantalla
              const Text(
                'Operación\nExitosa!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 48,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 250),
                child: Text(
                  'Código verificado.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}