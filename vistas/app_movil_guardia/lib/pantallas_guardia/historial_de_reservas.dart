import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'historial_de_reservas_detalles.dart';
import 'verificaciones/eliminar_reserva_erroneo2.dart';
import 'verificaciones/eliminar_reserva_exitoso2.dart';

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({Key? key}) : super(key: key);

  @override
  ReservasScreenState createState() => ReservasScreenState();
}

class ReservasScreenState extends State<ReservasScreen> {
  List<Map<String, String>> reservas = [];
  List<Map<String, String>> filteredReservas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReservasWithDelay(); // Usar método con retraso
  }

  Future<void> _fetchReservasWithDelay() async {
    // Retrasar la ejecución por 20 segundos antes de hacer la solicitud
    await Future.delayed(Duration(seconds: 20));
    await _fetchReservas();
  }

  Future<void> _fetchReservas() async {
    final response = await http.post(
      Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/historial'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        reservas = List<Map<String, String>>.from(data['reservations']
            .map((reservation) => Map<String, String>.from(reservation)));
        filteredReservas = List.from(reservas);
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener el historial de reservas')),
      );
    }
  }

  void _filterReservas(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredReservas = List.from(reservas);
      });
    } else {
      setState(() {
        filteredReservas = reservas.where((reserva) {
          return reserva['Modelo']!.toLowerCase().contains(query.toLowerCase()) ||
              reserva['Patente']!.toLowerCase().contains(query.toLowerCase()) ||
              reserva['Campus']!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  void _showEliminarReserva2Dialog(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: const Text(
            "¿Estás seguro que deseas eliminar la reserva?",
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black
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
                      reservas.removeAt(index);
                      filteredReservas.removeAt(index);
                    });
                    Navigator.of(context).pop(); // Cierra el diálogo
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EliminarReservaExito2Widget()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4), // Color verde para confirmación
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 15),
                  ),
                  child: const Text("Sí", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cierra el diálogo
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EliminarReservaError2Widget()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4), // Color rojo para cancelación
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Text(
              'Historial de Reservas',
              style: TextStyle(fontFamily: 'Lato', fontSize: width * 0.06, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: TextField(
              onChanged: _filterReservas,
              decoration: InputDecoration(
                labelText: 'Buscar',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredReservas.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(filteredReservas[index]['Modelo']!),
                      subtitle: Text('${filteredReservas[index]['Patente']} - ${filteredReservas[index]['Campus']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.info),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetalleReservaScreen(reserva: filteredReservas[index]),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _showEliminarReserva2Dialog(context, index),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Acción al tocar la reserva
                      },
                    ),
                    const Divider(height: 1),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
