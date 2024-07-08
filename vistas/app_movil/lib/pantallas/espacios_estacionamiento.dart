import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'usuario.dart';
import 'detalle_orden.dart';

class EspacioEstacionamientoWidget extends StatefulWidget {
  final String userId;
  final String sectionName;
  final String sedeName;
  final String vehicleid;
  final DateTime selectedDate;
  final TimeOfDay timeFrom;
  final TimeOfDay timeTo;

  const EspacioEstacionamientoWidget({Key? key, required this.userId,
    required this.sectionName, required this.sedeName, required this.vehicleid,
    required this.selectedDate, required this.timeFrom, required this.timeTo,
  }) : super(key: key);

  @override
  _EspacioEstacionamientoWidgetState createState() =>
      _EspacioEstacionamientoWidgetState();
}

class _EspacioEstacionamientoWidgetState
    extends State<EspacioEstacionamientoWidget> {
  List<String> estacionamientos = [];
  Map<String, bool> ocupados = {};

  @override
  void initState() {
    super.initState();
    _loadEstacionamientos();
  }

  Future<void> _loadEstacionamientos() async {
    try {
      final response = await http.post(
        Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/estacionamientos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'sectionName': widget.sectionName,
          'sedeName': widget.sedeName,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            estacionamientos = List<String>.from(data['estacionamientos']);
            ocupados = {for (var e in estacionamientos) e: false};
          });
          await _checkOcupados();
        } else {
          print('Error en la API: ${data['message']}');
        }
      } else {
        print('Error de red: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de carga de estacionamientos: $e');
    }
  }

  Future<void> _checkOcupados() async {
    try {
      for (String estNum in estacionamientos) {
        final response = await http.post(
          Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/ocupados'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'estNum': estNum,
            'selectedDate': widget.selectedDate.toIso8601String(),
            'timeFrom': '${widget.timeFrom.hour}:${widget.timeFrom.minute}',
            'timeTo': '${widget.timeTo.hour}:${widget.timeTo.minute}',
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['success']) {
            setState(() {
              ocupados[estNum] = data['status'];
            });
          }
        } else {
          print('Failed to check ocupados for $estNum');
        }
      }
    } catch (e) {
      print('Error checking ocupados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return CustomUserDialog(userId: widget.userId);
                },
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
            child: const Text(
              'Selecciona los espacios de estacionamiento requeridos',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            child: Text(
              'Sección: ${widget.sectionName} - Sede: ${widget.sedeName}',
              style: const TextStyle(
                fontFamily: 'Lato',
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: estacionamientos.length,
              itemBuilder: (context, index) {
                String estNum = estacionamientos[index];
                bool ocupado = ocupados[estNum] ?? false;
                return GestureDetector(
                  onTap: () {
                    if (!ocupado) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            userId: widget.userId,
                            vehicleid: widget.vehicleid,
                            selectedDate: widget.selectedDate,
                            timeFrom: widget.timeFrom,
                            timeTo: widget.timeTo,
                            estacionamiento: estNum,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          ocupado
                              ? 'assets/images/ocupado.png'
                              : 'assets/images/disponible.png',
                          fit: BoxFit.cover,
                          width: 75,
                          height: 70,
                        ),
                        Text(
                          estNum,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            backgroundColor: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}