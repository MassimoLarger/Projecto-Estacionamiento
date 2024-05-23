import 'package:flutter/material.dart';

class InicioWidget extends StatefulWidget {
  const InicioWidget({super.key});
  @override
  InicioWidgetState createState() => InicioWidgetState();
}

class InicioWidgetState extends State<InicioWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,  // Responsive width
      height: MediaQuery.of(context).size.height,  // Responsive height
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Color.fromRGBO(255, 255, 255, 255),  // Correct alpha value
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
                color: Color.fromRGBO(243, 246, 255, 255),  // Correct alpha value
              ),
              child: Stack(
                children: <Widget>[
                  const Positioned(
                    top: 478,
                    left: 80,
                    child: Text(
                      'PARKING APP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 255),
                        fontFamily: 'Monoton',
                        fontSize: 32,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 531,
                    left: 80,
                    child: Text(
                      'ULAGOS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 255),
                        fontFamily: 'Monoton',
                        fontSize: 32,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 32,
                    child: Container(
                      width: 401,
                      height: 304,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/logo.png'),
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