import 'package:flutter/material.dart';
import 'registrar_vehiculo.dart'; // Ensure this file is correctly configured.

class VehicleTypeSelector extends StatefulWidget {
  const VehicleTypeSelector({super.key});
  @override
  VehicleTypeSelectorState createState() => VehicleTypeSelectorState();
}

class VehicleTypeSelectorState extends State<VehicleTypeSelector> {
  int _selectedIndex = -1;

  final List<Map<String, dynamic>> vehicles = [
    {'name': 'Automóvil', 'icon': Icons.directions_car},
    {'name': 'Camión', 'icon': Icons.local_shipping},
    {'name': 'Moto', 'icon': Icons.motorcycle},
    {'name': 'Camioneta', 'icon': Icons.airport_shuttle},
    {'name': 'Furgon', 'icon': Icons.airport_shuttle},
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double scaleText(double size) => size * MediaQuery.textScaleFactorOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: SizedBox(
              height: 4,
              width: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: scaleText(20)), // Dynamically scaled vertical space
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05), // 5% of total width
            child: Text(
              "SELECCIONA TU TIPO DE VEHÍCULO",
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: scaleText(16), // Dynamically scaled font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: scaleText(18)), // More dynamically scaled vertical space
          Padding(  // Added padding to align with the text above
            padding: EdgeInsets.symmetric(horizontal: width * 0.05), // 5% of total width
            child: SizedBox(
              height: 170, // Specifies the height of the horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterVehiclePage()),
                      );
                    },
                    child: SizedBox(
                      width: width * 0.4, // 40% of the screen width
                      child: Card(
                        color: isSelected ? const Color(0xFF567DF4) : const Color(0xFFB7C7F9),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(vehicles[index]['icon'], size: scaleText(35), color: isSelected ? Colors.white : Colors.black),
                            SizedBox(height: scaleText(8)), // Dynamically scaled spacing
                            Text(
                              vehicles[index]['name'],
                              style: TextStyle(
                                fontSize: scaleText(20), // Dynamically scaled font size
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            if (isSelected)
                              const Icon(Icons.check_box, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}