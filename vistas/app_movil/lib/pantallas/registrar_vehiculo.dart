import 'package:flutter/material.dart';

class RegisterVehiclePage extends StatelessWidget {
  const RegisterVehiclePage({super.key});

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
              // Placeholder for functionality
            },
          ),
        ],
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView( // Removed Center to control padding more effectively
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.05, // Reduced top padding significantly
            left: screenWidth * 0.09,
            right: screenWidth * 0.09,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Align items to the start of the column
            crossAxisAlignment: CrossAxisAlignment.center, // Center alignment horizontally
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
              SizedBox(height: screenHeight * 0.17), // Adjust space between title and image
              Image.asset('assets/images/imagen5.png', fit: BoxFit.contain),
              SizedBox(height: screenHeight * 0.19), // Adjust space between image and buttons
              ElevatedButton(
                onPressed: () {
                  // Placeholder for functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // Adjust vertical padding
                  minimumSize: Size(screenWidth * 0.8, 50), // Set minimum size for button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5)
                  ),
                ),
                child: const Text(
                  'Agregar vehículo nuevo',
                  style: TextStyle(fontSize: 16, fontFamily: 'Lato', color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.02), // Space between buttons
              ElevatedButton(
                onPressed: () {
                  // Placeholder for functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01), // Adjust vertical padding
                  minimumSize: Size(screenWidth * 0.8, 50), // Set minimum size for button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5)
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
