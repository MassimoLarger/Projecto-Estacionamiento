import 'package:flutter/material.dart';
import 'patentes.dart';

class VehicleInterface extends StatelessWidget {
  final int userId;
  const VehicleInterface({Key? key, required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF677191),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            color: const Color(0xFF677191),
            child: const Row(
              children: [
                Icon(Icons.account_circle, color: Color.fromARGB(255, 0, 0, 0)),
                SizedBox(width: 10),
                Text("Usuario123", style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
          Image.asset('path_to_vehicle_image'),  // Asegúrate de tener una imagen adecuada
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text("Vehículo", style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 25, color: Colors.black)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Toyota Tacoma", style: TextStyle(fontSize: 18)),
                Text("CJ CH 25", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PatentesPage(), 
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
