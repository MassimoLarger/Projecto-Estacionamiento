import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'usuario.dart';
import 'verificaciones/cancelar_reserva_time.dart';

class VehicleTimeReserva extends StatefulWidget {
  final String userId;
  final String vehicleid;
  final TimeOfDay timeFrom;
  final TimeOfDay timeTo;

  const VehicleTimeReserva({
    Key? key,
    required this.userId,
    required this.vehicleid,
    required this.timeFrom,
    required this.timeTo,
  }) : super(key: key);

  @override
  _VehicleTimeReservaState createState() => _VehicleTimeReservaState();
}

class _VehicleTimeReservaState extends State<VehicleTimeReserva> {
  int _seconds = 0; // Inicializado en 0, se actualizará con la duración calculada
  late Timer _timer;
  String _userName = 'Usuario';
  String _vehicleModel = 'Vehículo';
  String _vehiclePlate = 'CJ CH 25';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchVehicleInfo();
    _calculateDuration(); // Calcular la duración inicial al inicio

    // Iniciar el timer
    _startTimer();
  }

  Future<void> _fetchUserName() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3500/api/consultau'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'correo': widget.userId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            _userName = data['usuario']['nombre'];
          });
        } else {
          setState(() {
            _userName = 'Usuario no encontrado';
          });
        }
      } else {
        setState(() {
          _userName = 'Error en la consulta';
        });
      }
    } catch (e) {
      setState(() {
        _userName = 'Error de red';
      });
    }
  }

  Future<void> _fetchVehicleInfo() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3500/api/vehiculoR'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'patente': widget.vehicleid}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            _vehicleModel = data['patentes']['descripcion'];
            _vehiclePlate = data['patentes']['patente'];
          });
        } else {
          setState(() {
            _vehicleModel = 'Vehículo no encontrado';
          });
        }
      } else {
        setState(() {
          _vehicleModel = 'Error en la consulta';
        });
      }
    } catch (e) {
      setState(() {
        _vehicleModel = 'Error de red';
      });
    }
  }

  void _cancelarReserva() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3500/api/cancelar-reserva'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': widget.userId,
          'vehicleid': widget.vehicleid,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          setState(() {
            _seconds = 0;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => CancelarReservatimeWidget(
                  userId: widget.userId,
                  vehicleid: widget.vehicleid,
                ),
              ),
            );
          });
        } else {
          // Manejo de errores si no se pudo cancelar la reserva
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(data['error'] ?? 'No se pudo cancelar la reserva.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        // Manejo de errores si no se pudo conectar con el servidor
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error de conexión con el servidor.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Manejo de errores si hubo una excepción
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Error inesperado: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateDuration() {
    // Calcular la duración en segundos entre timeFrom y timeTo
    final startSeconds = widget.timeFrom.hour * 3600 + widget.timeFrom.minute * 60;
    final endSeconds = widget.timeTo.hour * 3600 + widget.timeTo.minute * 60;
    _seconds = endSeconds - startSeconds;
  }

  String _formatDuration(int seconds) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final int hours = seconds ~/ 3600;
    final int minutes = (seconds % 3600) ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(remainingSeconds)}';
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
                    _cancelarReserva();
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: const Color(0xFF677191),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return CustomUserDialog(userId: widget.userId);
                        },
                      );
                    },
                    child: const Icon(Icons.account_circle, color: Colors.white, size: 40),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(_userName, style: const TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Expanded(
              child: Image.asset('assets/images/camioneta.png', fit: BoxFit.contain),
            ),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Vehículo", style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 25)),
                    const SizedBox(height: 10),
                    Text(_vehicleModel, style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 5),
                    Text(_vehiclePlate, style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              width: size.width,
              color: const Color(0xFF677191),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatDuration(_seconds),
                      style: TextStyle(fontSize: size.width * 0.05, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.pause, color: Colors.white, size: size.width * 0.08),
                      onPressed: () => _showCancelarReservaDialog(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}