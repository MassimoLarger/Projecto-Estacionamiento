import 'package:flutter/material.dart';
//import '../contrasena_seguridad.dart';

class EliminarReservaError2Widget extends StatefulWidget {
  const EliminarReservaError2Widget({super.key});

  @override
  EliminarReservaError2WidgetState createState() => EliminarReservaError2WidgetState();
}

class EliminarReservaError2WidgetState extends State<EliminarReservaError2Widget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // Aquí puedes decidir si el usuario debe regresar a la pantalla de ingreso de código
      // o a otra pantalla relevante. Aquí simplemente cerramos esta pantalla de error.
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const PasswordAndSecurityPage())); // Vuelve a la pantalla anterior.
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
          color: Color.fromRGBO(255, 236, 239, 1),
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
              SizedBox(height: screenHeight * 0.05), // 5% de la altura de la pantalla
              const Text(
                'Operación\nFallida!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Lato',
                  fontSize: 48,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 250),
                child: Text(
                  'No se ha eliminado la reserva.',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
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