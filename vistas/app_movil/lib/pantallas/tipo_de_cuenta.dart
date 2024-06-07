//import 'codigo_verificado.dart';
//import 'codigo_erroneo.dart';
import 'package:flutter/material.dart';
import 'registrar.dart';

class TipodecuentaWidget extends StatefulWidget {
  const TipodecuentaWidget({super.key});
  @override
  TipodecuentaWidgetState createState() => TipodecuentaWidgetState();
}

class TipodecuentaWidgetState extends State<TipodecuentaWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 570.095947265625,
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
              _buildButton(context, "Visita", Colors.blue, "Visita"),
              _buildButton(context, "Academico/Funcionario", Colors.blue,
                  "Academico/Funcionario"),
              _buildButton(context, "Estudiante", Colors.blue, "Estudiante"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color,
      String tipoCuenta) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(tipoCuenta: tipoCuenta),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(198, 212, 255, 1),
            foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
            textStyle: const TextStyle(fontSize: 16),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27.5),
            ),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}