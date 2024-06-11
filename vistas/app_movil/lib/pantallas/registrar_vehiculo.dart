import 'package:flutter/material.dart';
import 'sede.dart';  // Importa tu SelectCampusPage
import 'patente_modelo.dart';  // Importa tu VehicleInfoPage
import 'usuario.dart';

class RegisterVehiclePage extends StatelessWidget {
  final int userId;
  final int vehicleId;

  const RegisterVehiclePage({Key? key, required this.userId, required this.vehicleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener las dimensiones de la pantalla para un diseño responsivo
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
                  return const CustomUserDialog();
                },
              );
            },
          ),
        ],
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.05,
            left: screenWidth * 0.09,
            right: screenWidth * 0.09,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Registre su vehículo',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.17),
              Image.asset('assets/images/imagen5.png', fit: BoxFit.contain),
              SizedBox(height: screenHeight * 0.16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VehicleInfoPage(userId: userId, vehicleId: vehicleId),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  minimumSize: Size(screenWidth * 0.8, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                ),
                child: const Text(
                  'Agregar vehículo nuevo',
                  style: TextStyle(fontSize: 16, fontFamily: 'Lato', color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectCampusPage(), //SelectCampusPage(userId: userId) - Pasa userId
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  minimumSize: Size(screenWidth * 0.8, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                ),
                child: const Text(
                  'Vehículos guardados',
                  style: TextStyle(fontSize: 16, fontFamily: 'Lato', color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}