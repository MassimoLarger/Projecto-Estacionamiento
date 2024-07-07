import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'verificaciones/reserva_espacio.dart';
import 'verificaciones/cancelar_reserva.dart';
import 'usuario.dart';

class DetailScreen extends StatelessWidget {
  final String userId;
  final String vehicleid;
  final DateTime selectedDate;
  final TimeOfDay timeFrom;
  final TimeOfDay timeTo;
  final String estacionamiento;

  const DetailScreen({Key? key, required this.userId, required this.vehicleid,
    required this.selectedDate, required this.timeFrom, required this.timeTo,
    required this.estacionamiento,}) : super(key: key);

  Future<void> _confirmarReserva(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/reserva'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'userId': userId,
          'estacionamiento': estacionamiento,
          'selectedDate': selectedDate.toIso8601String(),
          'timeFrom': '${timeFrom.hour}:${timeFrom.minute}',
          'timeTo': '${timeTo.hour}:${timeTo.minute}',
          'vehicleid': vehicleid,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => ReservaEspacioWidget(
                userId: userId,
                vehicleid: vehicleid,
                timeFrom: timeFrom,
                timeTo: timeTo,
              ),
            ),
          );
        } else {
          _showErrorDialog(context, data['message'] ?? 'Error al reservar el espacio');
        }
      } else {
        _showErrorDialog(context, 'Error al reservar el espacio');
      }
    } catch (e) {
      _showErrorDialog(context, 'Error de red: $e');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showConfirmarReservaDialog(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "¿Estás seguro que deseas reservar?",
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
                    Navigator.of(context).pop(); // Close the dialog
                    _confirmarReserva(context); // Call the reservation function
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
                  onPressed: () => Navigator.of(context).pop(),
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

  void _showCancelarReservaDialog(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "¿Estás seguro que deseas cancelar tu reserva?",
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
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => CancelarReservaWidget(
                          userId: userId,
                          vehicleid: vehicleid,
                        ),
                      ),
                    );
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
                  onPressed: () => Navigator.of(context).pop(),
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return CustomUserDialog(userId: userId);
                },
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Detalle de Orden',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Lato'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(width * 0.07),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F6FF),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailItem(title: 'Espacio:', value: estacionamiento),
                  DetailItem(title: 'Fecha:', value: '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                  DetailItem(title: 'Hora:', value: '${timeFrom.format(context)} - ${timeTo.format(context)}'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ButtonTheme(
              minWidth: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  minimumSize: Size(width, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                ),
                onPressed: () => _showConfirmarReservaDialog(context),
                child: const Text(
                  'Confirmar Reserva',
                  style: TextStyle(fontSize: 16, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ButtonTheme(
              minWidth: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  minimumSize: Size(width, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                ),
                onPressed: () => _showCancelarReservaDialog(context),
                child: const Text(
                  'Cancelar Reserva',
                  style: TextStyle(fontSize: 16, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String title;
  final String value;

  const DetailItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.black54, fontSize: 16, fontFamily: 'Lato')),
        Text(value, style: const TextStyle(fontSize: 18, fontFamily: 'Lato')),
        const SizedBox(height: 10),
      ],
    );
  }
}