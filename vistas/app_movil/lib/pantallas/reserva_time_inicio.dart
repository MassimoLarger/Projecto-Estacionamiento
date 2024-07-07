import 'dart:async';
import 'package:flutter/material.dart';
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
  late Timer _timer;
  int _seconds = 0; // Declaración e inicialización de _seconds
  String _userName = 'Usuario';
  String _vehicleModel = 'Vehículo';
  String _vehiclePlate = 'CJ CH 25';
  String _vehicleImage = 'assets/images/auto.png'; // Imagen por defecto

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchVehicleInfo();
    _calculateDuration(); // Calcular la duración inicial

    // Iniciar el timer si la hora local es mayor o igual a timeFrom
    DateTime now = DateTime.now();
    DateTime timeFromDateTime = DateTime(now.year, now.month, now.day, widget.timeFrom.hour, widget.timeFrom.minute);
    if (now.isAfter(timeFromDateTime) || now.isAtSameMomentAs(timeFromDateTime)) {
      _startTimer();
    }

    // Verificar si la hora actual es mayor que timeTo para cancelar la reserva automáticamente
    DateTime timeToDateTime = DateTime(now.year, now.month, now.day, widget.timeTo.hour, widget.timeTo.minute);
    if (now.isAfter(timeToDateTime)) {
      _cancelarReservaAutomatica();
    }
  }

  Future<void> _fetchUserName() async {
    try {
      final response = await http.post(
        Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/consultau'),
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
        Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/vehiculoR'),
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
            int vehicleTypeId = data['patentes']['id_tipo_v'];
            _setVehicleImage(vehicleTypeId);
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

  void _setVehicleImage(int vehicleTypeId) {
    switch (vehicleTypeId) {
      case 1:
        _vehicleImage = 'assets/images/auto.png';
        break;
      case 2:
        _vehicleImage = 'assets/images/camion.png';
        break;
      case 3:
        _vehicleImage = 'assets/images/moto.png';
        break;
      case 4:
        _vehicleImage = 'assets/images/camioneta.png';
        break;
      case 5:
        _vehicleImage = 'assets/images/furgon.png';
        break;
      default:
        _vehicleImage = 'assets/images/auto.png';
    }
  }

  void _cancelarReservaAutomatica() {
    _timer.cancel();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => CancelarReservatimeWidget(
          userId: widget.userId,
          vehicleid: widget.vehicleid,
        ),
      ),
    );
  }

  void _cancelarReserva() async {
    try {
      final response = await http.post(
        Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/cancelar-reserva'),
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
            _timer.cancel();
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
          _showErrorDialog(data['error'] ?? 'No se pudo cancelar la reserva.');
        }
      } else {
        // Manejo de errores si no se pudo conectar con el servidor
        _showErrorDialog('Error de conexión con el servidor.');
      }
    } catch (e) {
      // Manejo de errores si hubo una excepción
      _showErrorDialog('Error inesperado: $e');
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _vehicleModel,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    _vehicleImage,
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Placa: $_vehiclePlate',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Tiempo restante:',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _formatDuration(_seconds),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showCancelarReservaDialog(context);
                    },
                    child: const Text('Cancelar Reserva'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
