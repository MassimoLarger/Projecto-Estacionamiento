import 'package:flutter/material.dart';
import 'tipo_vehiculo.dart';
import 'usuario.dart';

class CarSelectionWidget extends StatelessWidget {
  final String userId; // Cambiado a String

  const CarSelectionWidget({Key? key, required this.userId}) : super(key: key);

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
                  return CustomUserDialog(userId: userId);
                },
              );
            },
          ),
        ],
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
            child: const Text(
              '¿En qué te movilizas hoy?',
              style: TextStyle(
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
              child: Image.asset('assets/images/imagen4.png', fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.1),
            child: SizedBox(
              width: screenWidth * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  showVehicleTypeSelector(context, userId);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                ),
                child: const Text(
                  'Seleccione su Vehículo',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Lato', color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showVehicleTypeSelector(BuildContext context, String userId) { // Cambiado a String
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return VehicleTypeSelector(userId: userId); // Pasar userId como String
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
  );
}