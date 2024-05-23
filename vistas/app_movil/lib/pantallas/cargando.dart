import 'package:flutter/material.dart';

class CargandoWidget extends StatelessWidget {
  const CargandoWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, // Responsive width
      height: MediaQuery.of(context).size.height, // Responsive height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromRGBO(243, 246, 255, 1),
      ),
      child: Center(
        child: Container(
          width: 110.954, // Ajustado para simplificar
          height: 84.1148, // Ajustado para simplificar
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
