import 'package:flutter/material.dart';

class CargandoWidget extends StatelessWidget {
  const CargandoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Utilizar MediaQuery para obtener las dimensiones de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth, // Ancho responsive
      height: screenHeight, // Alto responsive
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromRGBO(243, 246, 255, 1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container para la imagen, adaptado a una proporción de la pantalla
            Container(
              width: screenWidth * 0.3,  // 30% del ancho de la pantalla
              height: screenHeight * 0.2, // 20% de la altura de la pantalla
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain,  // Cambiado a contain para evitar distorsión
                ),
              ),
            ),
            const SizedBox(height: 20),  // Espacio entre la imagen y el indicador
            const CircularProgressIndicator(),  // Indicador de progreso
            const SizedBox(height: 10),
            //const Text("Cargando...", style: TextStyle(fontSize: 16, color: Colors.blue)),  // Mensaje opcional
          ],
        ),
      ),
    );
  }
}