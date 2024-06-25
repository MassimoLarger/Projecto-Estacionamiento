import 'package:flutter/material.dart';
//import '../patentes.dart';

class EliminarPatenteWidget extends StatefulWidget {
  final String userId;
  final VoidCallback onCompleted;

  const EliminarPatenteWidget({Key? key, required this.userId, required this.onCompleted}) : super(key: key);

  @override
  EliminarPatenteWidgetState createState() => EliminarPatenteWidgetState();
}

class EliminarPatenteWidgetState extends State<EliminarPatenteWidget> {
   @override

  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      widget.onCompleted(); // Llama al callback antes de volver a la pantalla de patentes
      Navigator.of(context).pop(); // Cierra esta pantalla
    });
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
                  'Se ha eliminado tu patente.',
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