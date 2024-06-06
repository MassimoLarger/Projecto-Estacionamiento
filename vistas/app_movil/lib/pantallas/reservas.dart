import 'package:flutter/material.dart';

class ReservasScreen extends StatelessWidget {
  ReservasScreen({super.key});

  final List<Map<String, String>> reservas = [
    {
      'fecha': '06/06/2024',
      'hora_inicio': '10:00 AM',
      'hora_fin': '12:00 PM',
      'campus': 'Campus Chuyaca',
      'modelo_vehiculo': 'Toyota Corolla',
      'patente': 'XYZ123'
    },
    {
      'fecha': '06/06/2024',
      'hora_inicio': '10:00 AM',
      'hora_fin': '12:00 PM',
      'campus': 'Campus Meyer',
      'modelo_vehiculo': 'Toyota Corolla',
      'patente': 'XYZ123'
    },
    // Añadir más reservas aquí...
  ];

  @override
  Widget build(BuildContext context) {
    // Dimensiones de la pantalla para diseños responsivos
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adaptar tamaños de fuente según el tamaño de la pantalla
    double titleFontSize = screenWidth < 600 ? 20 : 24; // Menor para teléfonos, mayor para tablets
    double listTitleFontSize = screenWidth < 600 ? 16 : 18; // Menor para teléfonos, mayor para tablets

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
            child: Text(
              'Reservas',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: reservas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Reserva ${index + 1}',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: listTitleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Fecha: ${reservas[index]['fecha']}\n'
                    'Hora: ${reservas[index]['hora_inicio']} - ${reservas[index]['hora_fin']}\n'
                    'Campus: ${reservas[index]['campus']}\n'
                    'Modelo del vehículo: ${reservas[index]['modelo_vehiculo']}\n'
                    'Patente: ${reservas[index]['patente']}'
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
