import 'package:flutter/material.dart';

class TipodecuentaWidget extends StatefulWidget {
  const TipodecuentaWidget({super.key});
  @override
  TipodecuentaWidgetState createState() => TipodecuentaWidgetState();
}

class TipodecuentaWidgetState extends State<TipodecuentaWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,  // Responsive width
        height: MediaQuery.of(context).size.height,  // Responsive height
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: SingleChildScrollView( // Allows for scrolling when content is overflow
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 128,
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
                padding: EdgeInsets.only(top: 50, bottom: 10),
                child: Text(
                  'Seleccione su tipo de cuenta',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Lato',
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                    height: 1.5,
                  ),
                ),
              ),
              _buildButton(context, "Visita", Colors.blue), //,VisitaScreen()),
              _buildButton(context, "Academico/Funcionario", Colors.blue), //,VisitaScreen()),
              _buildButton(context, "Estudiante", Colors.blue), //,VisitaScreen()),
              _buildButton(context, "Guardia", Colors.blue), //,VisitaScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color){ //, Widget destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: SizedBox(
        width: double.infinity, // Makes the button expand to fill the width
        child: ElevatedButton(
          onPressed: () {
            // Add your onPressed code here!
            print('$text button pressed');
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
