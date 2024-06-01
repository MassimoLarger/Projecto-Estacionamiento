import 'package:flutter/material.dart';
import 'verificaciones/vehiculo_agregado.dart';

class VehicleInfoPage extends StatelessWidget {
  const VehicleInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Icono de volver ahora en negro
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              // Placeholder for functionality
            },
          ),
        ],
        backgroundColor: Colors.white, // Usando Colors.white directamente
        elevation: 0,
        // Sobreescribir el tema para asegurar el color blanco
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ingrese la patente y el modelo de su vehículo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Patente',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'CJ CH 25',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color.fromRGBO(198, 212, 255, 1),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Modelo',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Toyota Tacoma',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFC6D4FF),
                ),
              ),
              SizedBox(height: screenSize.height * 0.38),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VehiculoAgregadoWidget()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  foregroundColor: Colors.white,
                  minimumSize: Size(screenSize.width * 0.9, 50), // Hace que el botón sea tan ancho como el 90% del ancho de la pantalla
                ),
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
