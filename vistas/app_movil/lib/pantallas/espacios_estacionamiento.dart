import 'package:flutter/material.dart';
import 'usuario.dart';
import 'detalle_orden.dart';

class EspacioEstacionamientoWidget extends StatelessWidget {
  const EspacioEstacionamientoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener las dimensiones de la pantalla para un diseño responsivo
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const CustomUserDialog();
                },
              );
            },
          ),
        ],
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Central alignment vertically
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05), // 2% of total screen height
            child: const Text(
              'Selecciona los espacios de estacionamiento requeridos',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Image.asset('assets/images/estacionamiento.png', fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.1), // 5% of total screen width
            child: SizedBox(
              width: screenWidth * 0.9, // Button width set to 90% of screen width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DetailScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02), // 1% of total screen height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5)
                  )
                ),
                child: const Text(
                  'Continuar',
                  style: TextStyle(fontSize: 16, fontFamily: 'Lato', color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}