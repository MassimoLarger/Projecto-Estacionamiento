import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'verificaciones/vehiculo_agregado.dart';
import 'usuario.dart';

class VehicleInfoPage extends StatefulWidget {
  final int userId;
  final int vehicleId;

  const VehicleInfoPage({required this.userId, required this.vehicleId, super.key});

  @override
  _VehicleInfoPageState createState() => _VehicleInfoPageState();
}

class _VehicleInfoPageState extends State<VehicleInfoPage> {
  final TextEditingController _patenteController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  String? _errorMessage;

  Future<void> _addVehicle() async {
    final url = Uri.parse('http://192.168.0.105:3500/api/vehiculos');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'patente': _patenteController.text,
        'year': _yearController.text,
        'model': _modelController.text,
        'vehicleId': widget.vehicleId,
        'userId': widget.userId,
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['success']) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VehiculoAgregadoWidget()),
        );
      } else {
        setState(() {
          _errorMessage = responseBody['message'];
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Error en la solicitud. Inténtalo de nuevo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
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
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ingrese la patente, el año y el modelo de su vehículo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Patente',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _patenteController,
                decoration: InputDecoration(
                  hintText: 'CJ CH 25',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color.fromRGBO(198, 212, 255, 1),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Año',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _yearController,
                decoration: InputDecoration(
                  hintText: '2012',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color.fromRGBO(198, 212, 255, 1),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Modelo',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _modelController,
                decoration: InputDecoration(
                  hintText: 'Toyota Tacoma',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFC6D4FF),
                ),
              ),
              SizedBox(height: screenSize.height * 0.25),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ElevatedButton(
                onPressed: _addVehicle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  foregroundColor: Colors.white,
                  minimumSize: Size(screenSize.width * 0.9, 50),
                ),
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}