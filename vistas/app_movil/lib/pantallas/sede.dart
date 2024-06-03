import 'package:flutter/material.dart';
import 'chuyaca.dart';
import 'meyer.dart';
import 'usuario.dart';

class SelectCampusPage extends StatelessWidget {
  const SelectCampusPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener las dimensiones de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
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
        elevation: 0, // Remove the shadow of the AppBar
      ),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Seleccione la Sede\ndonde quiere reservar',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          campusCard('Chuyaca', 'assets/images/chuyaca.png', context, screenWidth, () {
            showSedeChuyacaSelector(context);
            // Action for Chuyaca
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChuyacaScreen()));
          }),
          campusCard('Meyer', 'assets/images/meyer.png', context, screenWidth, () {
            showSedeMeyerSelector(context);
            // Action for Meyer
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MeyerScreen()));
          }),
        ],
      ),
    );
  }

  Widget campusCard(String campusName, String imagePath, BuildContext context, double screenWidth, VoidCallback onPressed) {
    return Column(
      children: <Widget>[
        Image.asset(imagePath),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF567DF4), // Background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27.5),
            ),
            // Usa un ancho proporcional a la pantalla mientras mantienes un tamaño máximo
            fixedSize: Size(screenWidth * 0.8, 48),
          ),
          onPressed: onPressed,
          child: Text(
            campusName,
            style: const TextStyle(
              fontFamily: 'Lato',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 25), // Spacing between cards
      ],
    );
  }
}

void showSedeChuyacaSelector(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return const SedeChuyacaSelector();
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
     isScrollControlled: true, // Esto permite que el BottomSheet ocupe la altura necesaria
  );
 }

void showSedeMeyerSelector(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return const SedeMeyerSelector();
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
     isScrollControlled: true, // Esto permite que el BottomSheet ocupe la altura necesaria
  );
 }