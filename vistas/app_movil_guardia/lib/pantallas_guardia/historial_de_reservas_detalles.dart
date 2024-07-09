import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetalleReservaScreen extends StatefulWidget {
  final Map<String, String> reserva;

  const DetalleReservaScreen({super.key, required this.reserva});

  @override
  _DetalleReservaScreenState createState() => _DetalleReservaScreenState();
}

class _DetalleReservaScreenState extends State<DetalleReservaScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData(widget.reserva['patente']!); // Llama a la función para obtener datos de usuario al inicio
  }

  Future<void> _fetchUserData(String patente) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/consultaRegistro'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'vehicleid': patente,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final correo = data['correo'];

        // Llamar a la segunda API para obtener detalles del usuario
        await _fetchUsuario(correo);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al obtener datos del usuario')),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchUsuario(String correo) async {
    try {
      final response = await http.post(
        Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/consultau'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'correo': correo,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          userData = data['usuario'];
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al obtener datos del usuario')),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    TextStyle labelStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: screenWidth * 0.04,
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
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Historial de reservas',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                'Más detalles de la reserva',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: screenWidth * 0.045,
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
                            Text(widget.reserva['horas'] ?? '0 hr', style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.05),
              ...['Modelo', 'Patente', 'Campus'].map((label) {
                return TextField(
                  decoration: InputDecoration(labelText: label, labelStyle: labelStyle),
                  controller: TextEditingController(text: widget.reserva[label.toLowerCase()]),
                  readOnly: true,
                  enabled: false,
                );
              }),
              if (isLoading)
                CircularProgressIndicator()
              else if (userData != null)
                ...['Nombre', 'Teléfono', 'Tipo Cuenta', 'Correo'].map((label) {
                  return TextField(
                    decoration: InputDecoration(labelText: label, labelStyle: labelStyle),
                    controller: TextEditingController(text: userData![label.toLowerCase()]),
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
