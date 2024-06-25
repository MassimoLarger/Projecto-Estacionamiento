import 'package:flutter/material.dart';
import 'verificaciones/eliminar_reserva_erroneo2.dart';
import 'verificaciones/eliminar_reserva_exitoso2.dart';
import 'historial_de_reservas_detalles.dart';

class ReservasScreen extends StatefulWidget {
  const ReservasScreen({super.key});
  @override
  ReservasScreenState createState() => ReservasScreenState();
}

class ReservasScreenState extends State<ReservasScreen> {
  List<Map<String, String>> reservas = [
    {'modelo': 'Ford Ecoesport', 'patente': 'CU ML 69', 'campus': 'Meyer', 'fecha': '23/06/2024', 'hora': '16:00:17'},
    {'modelo': 'Audi A8', 'patente': 'CA MT 22', 'campus': 'Chuyaca', 'fecha': '10/05/2024', 'hora': '11:30:12'},
    // Añade más reservas aquí...
  ];

  List<Map<String, String>> filteredReservas = [];

  @override
  void initState() {
    super.initState();
    filteredReservas = List.from(reservas);
  }

  void _filterReservas(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredReservas = List.from(reservas);
      });
    } else {
      setState(() {
        filteredReservas = reservas.where((reserva) {
          return reserva['modelo']!.toLowerCase().contains(query.toLowerCase()) ||
                 reserva['patente']!.toLowerCase().contains(query.toLowerCase()) ||
                 reserva['campus']!.toLowerCase().contains(query.toLowerCase());
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
                fontSize: 16,  // Escala el tamaño de la fuente basado en el ancho de la pantalla
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
    double width = MediaQuery.of(context).size.width; // Obtener el ancho de pantalla
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
      body: Column(
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
                floatingLabelBehavior: FloatingLabelBehavior.never, // Mantiene la etiqueta en el campo de texto
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
                      title: Text(filteredReservas[index]['modelo']!),
                      subtitle: Text('${filteredReservas[index]['patente']} - ${filteredReservas[index]['campus']}'),
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
                    const Divider(height: 1), // Añade un Divider debajo de cada elemento
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