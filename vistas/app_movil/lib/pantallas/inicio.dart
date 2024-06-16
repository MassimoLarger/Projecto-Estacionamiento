import 'package:flutter/material.dart';
import 'patentes.dart';
import 'usuario.dart'; // Asegúrate de tener esta página definida

class VehicleInterface extends StatelessWidget {
  final int userId;
  const VehicleInterface({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CustomUserDialog()),
                      );
                    },
                    child: const Icon(Icons.account_circle, color: Colors.white, size: 40),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Usuario123", 
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Image.asset('assets/images/camioneta.png', fit: BoxFit.contain),
            ),
            Container(
              color: const Color.fromARGB(255, 255, 255, 255), // Ajuste de color para la franja detrás del botón
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Vehículo", style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 25)),
                        Text("Toyota Tacoma", style: TextStyle(fontSize: 18)),
                        Text("CJ CH 25", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),  // Espacio antes del botón
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 56,  // Altura del botón FAB
        width: 56,   // Anchura del botón FAB
        decoration: const BoxDecoration(
          color: Colors.blue, // Color del botón
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.add, size: 30, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PatentesPage()),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}