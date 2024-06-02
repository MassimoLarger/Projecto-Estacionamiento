import 'package:flutter/material.dart';
import 'verificaciones/contrasena_erronea.dart';
import 'verificaciones/contrasena_verificada.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,  // Esto evita que el diálogo se cierre al tocar fuera del cuadro
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "¿Estás seguro que deseas confirmar tu nueva contraseña?",
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black // Puedes elegir el color que desees
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Centra los botones en el diálogo
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ContrasenaVerificadaWidget()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4), // Color azul claro para el botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Si", style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ContrasenaErrorWidget()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4), // Mismo color para ambos botones
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("No", style: TextStyle(color: Colors.white)),
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
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirma tu nueva contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(198, 212, 255, 1),
              ),
            ),
            SizedBox(height: screenHeight * 0.14),
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