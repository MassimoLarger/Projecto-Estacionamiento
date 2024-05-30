import 'package:flutter/material.dart';
import 'iniciar_sesion.dart';

class InicioWidget extends StatefulWidget {
  const InicioWidget({super.key});
  @override
  InicioWidgetState createState() => InicioWidgetState();
}

class InicioWidgetState extends State<InicioWidget> {
  @override
  Widget build(BuildContext context) {
    // Obteniendo dimensiones de pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: screenWidth,  // Ancho responsive
        height: screenHeight,  // Alto responsive
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Color.fromRGBO(243, 246, 255, 1),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: screenHeight * 0.5,  // Posición relativa
              left: screenWidth * 0.15,  // Posición relativa
              child: const Text(
                'PARKING APP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Monoton', // Specify the custom font
                  color: Color.fromARGB(255, 0, 0, 0), // Custom color
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.57,  // Posición relativa
              left: screenWidth * 0.28,  // Posición relativa
              child: const Text(
                'ULAGOS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Monoton', // Specify the custom font
                  color: Color.fromARGB(255, 0, 0, 0), // Custom color
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.8,  // Posición relativa
              left: screenWidth * 0.15,  // Centrar el botón
              right: screenWidth * 0.15,  // Centrar el botón
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(86, 125, 244, 1),
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: screenWidth * 0.15),  // Padding proporcional
                ),
                child: const Text('Iniciar'),
              ),
            ),
            Positioned(
              top: screenHeight * 0.2,  // Posición relativa
              left: screenWidth * 0.03,  // Posición relativa
              child: Container(
                width: screenWidth * 0.9,  // Ancho proporcional
                height: screenHeight * 0.25,  // Alto proporcional
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
