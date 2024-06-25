import 'package:flutter/material.dart';
import 'usuario.dart';
import 'chuyaca.dart';
import 'meyer.dart';

class SelectCampusPage extends StatelessWidget {
  final String userId;

  const SelectCampusPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  return CustomUserDialog(userId: userId);
                },
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SedeChuyacaSelector(userId: userId)),
            );
          }),
          campusCard('Meyer', 'assets/images/meyer.png', context, screenWidth, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SedeMeyerSelector(userId: userId)),
            );
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
            backgroundColor: const Color(0xFF567DF4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27.5),
            ),
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
        const SizedBox(height: 25),
      ],
    );
  }
}