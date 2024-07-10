import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'usuario.dart';
//import 'modificar_reserva_1.dart';

class EspacioEstacionamientoWidget extends StatefulWidget {
  final String sectionName;
  final String sedeName;
  final String userId;

  const EspacioEstacionamientoWidget({super.key, required this.sectionName, required this.sedeName, required this.userId});

  @override
  EspacioEstacionamientoWidgetState createState() => EspacioEstacionamientoWidgetState();
}

class EspacioEstacionamientoWidgetState extends State<EspacioEstacionamientoWidget> {
  int espaciosDisponibles = 0;
  int espaciosReservados = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchParkingData();
  }

  Future<void> fetchParkingData() async {
    try {
      final response = await http.get(
          Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/estados-estacionamientos')
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        setState(() {
          espaciosDisponibles = data.where((e) => e['estado'] == 'disponible').length;
          espaciosReservados = data.where((e) => e['estado'] == 'reservado').length;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load parking data');
      }
    } catch (error) {
      print('Error fetching parking data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
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
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
            child: Text(
              'Estacionamiento ${widget.sectionName}', // Usar la sección dinámica
              style: const TextStyle(
                fontFamily: 'Lato',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Image.asset('assets/images/estacionamiento.png', fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildParkingStatusIndicator('Disponibles', espaciosDisponibles, const Color(0xFF2957C2), const Color(0xFF2957C2)),
              _buildParkingStatusIndicator('Reservados', espaciosReservados, Colors.red, Colors.red),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.1),
            child: SizedBox(
              width: screenWidth * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  //Navigator.push(
                    //context,
                    //MaterialPageRoute(builder: (context) => const DetailScreen1()),
                  //);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4),
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27.5)
                    )
                ),
                child: const Text(
                  'Continuar',
                  style: TextStyle(fontSize: 16, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParkingStatusIndicator(String title, int count, Color borderColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 5),
          Text(
            '$count',
            style: TextStyle(fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }
}
