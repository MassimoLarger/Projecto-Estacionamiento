import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MisVehiculosScreen extends StatefulWidget {
  final String userId;

  const MisVehiculosScreen({Key? key, required this.userId}) : super(key: key);

  @override
  MisVehiculosScreenState createState() => MisVehiculosScreenState();
}

class MisVehiculosScreenState extends State<MisVehiculosScreen> {
  List<Map<String, dynamic>> vehiculos = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchPatentes();
  }

  Future<void> _fetchPatentes() async {
    final url = Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/consultar');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'correo': widget.userId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success']) {
          final List<dynamic> patentes = responseBody['patentes'];

          // Retrieve details of each vehicle
          final List<Future<void>> vehiculosPromises = patentes.map((patente) async {
            await _fetchVehiculo(patente);
          }).toList();

          await Future.wait(vehiculosPromises);
        } else {
          setState(() {
            hasError = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody['message'])),
          );
        }
      } else {
        setState(() {
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchVehiculo(String patente) async {
    final url = Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/vehiculoR');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'patente': patente}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success']) {
          final vehiculo = responseBody['patentes'];

          setState(() {
            vehiculos.add({
              'modelo': vehiculo['descripcion'],
              'patente': vehiculo['patente'],
            });
          });
        } else {
          setState(() {
            hasError = true;
          });
        }
      } else {
        setState(() {
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
      });
    }
  }

  void _showConfirmationDialog(int index) {
    double width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "¿Estás seguro que deseas eliminar este vehículo?",
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: width * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      vehiculos.removeAt(index);
                      Navigator.of(context).pop();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 15),
                  ),
                  child: const Text("Sí", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 15),
                  ),
                  child: const Text("No", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _agregarVehiculoDialog() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.045;
    double labelFontSize = screenWidth * 0.04;

    TextEditingController modeloController = TextEditingController();
    TextEditingController patenteController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            'Agregar Vehículo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
              fontSize: fontSize,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Modelo del Vehículo',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: labelFontSize,
                  ),
                ),
                TextFormField(
                  controller: modeloController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Patente del Vehículo',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: labelFontSize,
                  ),
                ),
                TextFormField(
                  controller: patenteController,
                  decoration: const InputDecoration(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    vehiculos.add({
                      'modelo': modeloController.text,
                      'patente': patenteController.text,
                    });
                    Navigator.of(context).pop();
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.02),
                ),
                child: Text('Agregar', style: TextStyle(fontSize: fontSize)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06;
    double listTitleFontSize = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
          ? Center(child: Text('No hay vehiculos registrados'))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tus Vehículos',
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
              itemCount: vehiculos.length + 1,
              itemBuilder: (context, index) {
                if (index == vehiculos.length) {
                  return ListTile(
                    title: Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFF567DF4),
                        child: IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: _agregarVehiculoDialog,
                        ),
                      ),
                    ),
                  );
                }
                return ListTile(
                  title: Text(
                    vehiculos[index]['modelo'] ?? '',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: listTitleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text('Patente: ${vehiculos[index]['patente']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _showConfirmationDialog(index),
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
