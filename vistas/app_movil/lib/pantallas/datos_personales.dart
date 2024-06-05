import 'package:flutter/material.dart';

class UserDetails {
  String accountType;
  String phoneNumber;

  UserDetails({required this.accountType, required this.phoneNumber});
}

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  PersonalDetailsPageState createState() => PersonalDetailsPageState();
}

class PersonalDetailsPageState extends State<PersonalDetailsPage> {
  UserDetails user = UserDetails(accountType: 'Visita', phoneNumber: '+569 xxxxxxxx');

  @override
  Widget build(BuildContext context) {
    // Usando MediaQuery para adaptar el diseño a diferentes tamaños de pantalla
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSizeTitle = screenWidth < 600 ? 20 : 24;  // Adaptación del tamaño de fuente para el título
    double fontSizeSubTitle = screenWidth < 600 ? 16 : 18;  // Adaptación del tamaño de fuente para subtítulos

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.04),  // Padding proporcional al ancho de pantalla
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),  // Espaciado vertical basado en el ancho de pantalla
            child: Text(
              'Detalles Personales',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: fontSizeTitle,  // Tamaño de fuente adaptativo para título
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tipo de Cuenta',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: fontSizeSubTitle,  // Tamaño de fuente adaptativo para subtítulo
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                  child: Text(
                    user.accountType,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: fontSizeSubTitle - 2,  // Tamaño de fuente ligeramente menor para los detalles
                    ),
                  ),
                ),
                const Divider(),  // Línea horizontal debajo de cada detalle
                const SizedBox(height: 16),
                Text(
                  'Número de Teléfono',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: fontSizeSubTitle,  // Tamaño de fuente adaptativo para subtítulo
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                  child: Text(
                    user.phoneNumber,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: fontSizeSubTitle - 2,  // Tamaño de fuente ligeramente menor para los detalles
                    ),
                  ),
                ),
                const Divider(),  // Línea horizontal debajo de cada detalle
              ],
            ),
          ),
        ],
      ),
    );
  }
}
