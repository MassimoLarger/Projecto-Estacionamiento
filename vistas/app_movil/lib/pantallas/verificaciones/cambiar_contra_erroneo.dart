import 'package:flutter/material.dart';
import '../usuario.dart'; // Ajusta la ruta según la estructura de tu proyecto

class ContrasenaCambiadaErrorWidget extends StatefulWidget {
  final String userId;
  final String userPassword;

  const ContrasenaCambiadaErrorWidget({Key? key, required this.userId, required this.userPassword}) : super(key: key);

  @override
  _ContrasenaCambiadaErrorWidgetState createState() => _ContrasenaCambiadaErrorWidgetState();
}

class _ContrasenaCambiadaErrorWidgetState extends State<ContrasenaCambiadaErrorWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => CustomUserDialog(userId: widget.userId)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 236, 239, 1),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenWidth * 0.4,
                height: screenWidth * 0.4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.cancel,
                    size: 100,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              const Text(
                'Operación\nFallida!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lato',
                  fontSize: 48,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'No se ha cambiado la contraseña',
                  style: TextStyle(
                    color: Colors.black,
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