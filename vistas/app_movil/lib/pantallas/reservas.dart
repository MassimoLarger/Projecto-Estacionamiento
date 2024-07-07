import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservasScreen extends StatefulWidget {
  final String userId;

  const ReservasScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ReservasScreenState createState() => _ReservasScreenState();
}

class _ReservasScreenState extends State<ReservasScreen> {
  List<Map<String, dynamic>> reservas = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Llamar a la función para cargar las reservas desde la API
    _fetchReservas();
  }

  Future<void> _fetchReservas() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/reservations'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'correo': widget.userId}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          reservas = List<Map<String, dynamic>>.from(data['reservations']);
          isLoading = false;
        });
      } else {
        // Manejar errores de solicitud
        print('Error al cargar reservas: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      // Manejar errores de conexión u otros
      print('Error en la conexión: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double titleFontSize = screenWidth < 600 ? 20 : 24;
    double listTitleFontSize = screenWidth < 600 ? 16 : 18;

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
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : reservas.isEmpty
                ? Center(
              child: Text('No hay reservas disponibles'),
            )
                : ListView.separated(
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
                        'Patente: ${reservas[index]['patente']}',
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
