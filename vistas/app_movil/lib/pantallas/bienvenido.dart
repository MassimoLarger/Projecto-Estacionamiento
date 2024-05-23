import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InicioWidget extends StatefulWidget {
  const InicioWidget({super.key});
  @override
  InicioWidgetState createState() => InicioWidgetState();
}

class InicioWidgetState extends State<InicioWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,  // Ancho responsive
        height: MediaQuery.of(context).size.height,  // Alto responsive
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Color.fromRGBO(243, 246, 255, 1),  // Correct alpha value
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 478,
              left: 80,
              child: Text(
                'PARKING APP',
                textAlign: TextAlign.center,
                style: GoogleFonts.monoton(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                ),
              ),
            ),
            Positioned(
              top: 531,
              left: 130,
              child: Text(
                'ULAGOS',
                textAlign: TextAlign.center,
                style: GoogleFonts.monoton(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                ),
              ),
            ),
            Positioned(
              top: 750, // Ajustar según sea necesario
              left: MediaQuery.of(context).size.width * 0.32 - 90, // Centrar el botón
              child: ElevatedButton(
                onPressed: () {
                  // Acción cuando se presiona el botón
                  print("Botón presionado");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(86, 125, 244, 1),  // Usa backgroundColor en lugar de primary
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 1), // Color del texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                ),
                child: const Text('Iniciar'),
              ),
            ),
            Positioned(
              top: 100,
              left: 15,
              child: Container(
                width: 401,
                height: 304,
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