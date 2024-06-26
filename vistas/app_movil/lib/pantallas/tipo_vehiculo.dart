import 'package:flutter/material.dart';
import 'registrar_vehiculo.dart';

class VehicleTypeSelector extends StatefulWidget {
  final String userId;

  const VehicleTypeSelector({Key? key, required this.userId}) : super(key: key);

  @override
  VehicleTypeSelectorState createState() => VehicleTypeSelectorState();
}

class VehicleTypeSelectorState extends State<VehicleTypeSelector> {
  int _selectedIndex = -1;

  final List<Map<String, dynamic>> vehicles = [
    {'name': 'Automóvil', 'icon': Icons.directions_car, 'id': 1},
    {'name': 'Camión', 'icon': Icons.local_shipping, 'id': 2},
    {'name': 'Moto', 'icon': Icons.motorcycle, 'id': 3},
    {'name': 'Camioneta', 'icon': Icons.airport_shuttle, 'id': 4},
    {'name': 'Furgón', 'icon': Icons.airport_shuttle, 'id': 5},
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
          SizedBox(height: scaleText(20)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Text(
              "SELECCIONA TU TIPO DE VEHÍCULO",
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: scaleText(16),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: scaleText(18)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Text(
              "Antes de continuar, les recomendamos tener su permiso de circulación vigente, ya que necesitaremos la patente junto al dígito verificador de la forma 'FFFF11-1'.",
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: scaleText(14),
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: scaleText(18)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: SizedBox(
              height: 170,
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
                        MaterialPageRoute(
                          builder: (context) => RegisterVehiclePage(
                            userId: widget.userId,
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: width * 0.4,
                      child: Card(
                        color: isSelected ? const Color(0xFF567DF4) : const Color(0xFFB7C7F9),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(vehicles[index]['icon'], size: scaleText(35), color: isSelected ? Colors.white : Colors.black),
                            SizedBox(height: scaleText(8)),
                            Text(
                              vehicles[index]['name'],
                              style: TextStyle(
                                fontSize: scaleText(20),
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