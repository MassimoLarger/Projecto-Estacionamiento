import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'usuario.dart';
import 'movilizacion.dart';

class VehicleInterface extends StatefulWidget {
  final String userId;
  final String vehicleid;

  const VehicleInterface({Key? key, required this.userId, required this.vehicleid}) : super(key: key);

  @override
  _VehicleInterfaceState createState() => _VehicleInterfaceState();
}

class _VehicleInterfaceState extends State<VehicleInterface> {
  String _userName = 'Usuario';
  String _vehicleModel = 'Vehículo';
  String _vehiclePlate = 'CJ CH 25';
  String _vehicleImage = 'assets/images/auto.png'; // Default image

  @override
  void initState() {
    super.initState();
    // Delay the initialization by 10 seconds
    Future.delayed(Duration(seconds: 10), () {
      _fetchUserName();
      _fetchVehicleInfo();
    });
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
        _vehicleImage = 'assets/images/auto.png'; // Default fallback image
    }
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
                    child: Text(
                      _userName,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Expanded(
              child: Image.asset(
                _vehicleImage,
                fit: BoxFit.contain,
              ),
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
                    Text(
                      _vehicleModel,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _vehiclePlate,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Color(0xFF677191),
        shape: CircularNotchedRectangle(),
        notchMargin: -100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: size.height * 0.1),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CarSelectionWidget(
                  userId: widget.userId,
                ),
              ),
            );
          },
          backgroundColor: const Color(0xFF456EFF),
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
