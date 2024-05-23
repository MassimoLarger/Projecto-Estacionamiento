import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bienvenido.dart';

class TextWithStroke extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color strokeColor;
  final Color fillColor;
  final double strokeWidth;

  const TextWithStroke({
    super.key,
    required this.text,
    required this.fontSize,
    required this.strokeColor,
    required this.fillColor,
    this.strokeWidth = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Texto con borde (stroke)
        Text(
          text,
          style: GoogleFonts.monoton(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        // Texto de relleno (fill)
        Text(
          text,
          style: GoogleFonts.monoton(
            fontSize: fontSize,
            color: fillColor,
          ),
        ),
      ],
    );
  }
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
          color: Color.fromRGBO(243, 246, 255, 1),  // Valor alfa correcto
        ),
        child: Stack(
          children: <Widget>[
            const Positioned(
              top: 478,
              left: 80,
              child: TextWithStroke(
                text: 'PARKING APP',
                fontSize: 32,
                strokeColor: Colors.black,
                fillColor: Colors.white,
                strokeWidth: 2,
              ),
            ),
            const Positioned(
              top: 531,
              left: 80,
              child: TextWithStroke(
                text: 'ULAGOS',
                fontSize: 32,
                strokeColor: Colors.black,
                fillColor: Colors.white,
                strokeWidth: 2,
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
