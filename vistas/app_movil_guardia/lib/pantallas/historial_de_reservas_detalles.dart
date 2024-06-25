import 'package:flutter/material.dart';

class DetalleReservaScreen extends StatelessWidget {
  final Map<String, String> reserva;

  const DetalleReservaScreen({super.key, required this.reserva});

  @override
  Widget build(BuildContext context) {
    // Obteniendo dimensiones de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;

    // Estilo de las etiquetas de los campos de texto adaptadas al tamaño de pantalla
    TextStyle labelStyle = TextStyle(
      color: Colors.black, 
      fontWeight: FontWeight.bold, 
      fontSize: screenWidth * 0.04, // Adaptativo según el ancho de pantalla
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03), // Padding proporcional al tamaño de pantalla
        child: SingleChildScrollView( // Asegurando que todo sea scrollable en pantallas pequeñas
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Historial de reservas',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: screenWidth * 0.06, // Adaptativo
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                'Más detalles de la reserva',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: screenWidth * 0.045, // Adaptativo
                  color: const Color(0xFF5C5C5C),
                ),
              ),
              SizedBox(height: screenWidth * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      color: const Color(0xFFF3F8FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Color(0xFF1573FE),
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Column(
                          children: [
                            Text('Horas reservadas:', style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.045)),
                            Text(reserva['horas'] ?? '0 hr', style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.05),
              ...['Modelo', 'Patente', 'Campus', 'Usuario', 'Tipo Cuenta', 'Correo'].map((label) {
                return TextField(
                  decoration: InputDecoration(labelText: label, labelStyle: labelStyle),
                  controller: TextEditingController(text: reserva[label.toLowerCase()]),
                  readOnly: true,
                  enabled: false,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
