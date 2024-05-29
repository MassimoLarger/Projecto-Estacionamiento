import 'package:flutter/material.dart';
//import 'codigo_verificado.dart';
//import 'codigo_erroneo.dart';
import 'movilizacion.dart';

class TipodecuentaWidget extends StatefulWidget {
  const TipodecuentaWidget({super.key});
  @override
  TipodecuentaWidgetState createState() => TipodecuentaWidgetState();
}

class TipodecuentaWidgetState extends State<TipodecuentaWidget> {
  @override
    Widget build(BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width; // Ancho de pantalla
      final screenHeight = MediaQuery.of(context).size.height; // Alto de pantalla
      return Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          child: SingleChildScrollView( // Allows for scrolling when content is overflow
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: 570.095947265625, // You may need to adjust this to fit the container properly or use MediaQuery if needed
                  height: 321,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/foto1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 70),
                  child: Text(
                    'Seleccione su tipo de cuenta',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Lato',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                ),
                _buildButton(context, "Visita", Colors.blue, const CarSelectionWidget()),
                _buildButton(context, "Academico/Funcionario", Colors.blue, const CarSelectionWidget()),
                _buildButton(context, "Estudiante", Colors.blue, const CarSelectionWidget()),
              ],
            ),
          ),
        ),
      );
    }

  Widget _buildButton(BuildContext context, String text, Color color, Widget destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: SizedBox(
        width: double.infinity, // Makes the button expand to fill the width
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CarSelectionWidget()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:  const Color.fromRGBO(198, 212, 255, 1), // Button color
            foregroundColor: const Color.fromRGBO(0, 0, 0, 1), // Text color
            textStyle: const TextStyle(fontSize: 16),
            padding: const EdgeInsets.symmetric(vertical: 15), // Button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27.5), // Rounded corners
            ),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}