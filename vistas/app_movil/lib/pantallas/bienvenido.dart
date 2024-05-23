import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InicioWidget extends StatefulWidget {
  const InicioWidget({super.key});
  @override
  InicioWidgetState createState() => InicioWidgetState();

  Widget buildTextWithStroke({
  required String text,
  required double fontSize,
  required Color strokeColor,
  required Color fillColor,
  double strokeWidth = 3,
}) {
  return Stack(
    children: <Widget>[
      // Texto con borde (stroke)
      Text(
        text,
        style: TextStyle(
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
        style: TextStyle(
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
    return Container(
      width: MediaQuery.of(context).size.width,  // Responsive width
      height: MediaQuery.of(context).size.height,  // Responsive height
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Color.fromRGBO(243, 246, 255, 1),  // Correct alpha value
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,  // Responsive width
              height: MediaQuery.of(context).size.height,  // Responsive height
              decoration: const BoxDecoration(
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
                    left: 80,
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
          ),
        ],
      ),
    );
  }
}
