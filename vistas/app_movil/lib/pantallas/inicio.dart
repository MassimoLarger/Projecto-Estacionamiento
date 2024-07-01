import 'package:flutter/material.dart';
import 'sede.dart';
import 'usuario.dart';

class VehicleInterface extends StatelessWidget {
  final String userId;
  final String vehicleid;

  const VehicleInterface({super.key, required this.userId, required this.vehicleid});

  @override
  Widget build(BuildContext context) {
    // MediaQuery para obtener el tamaño de la pantalla
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
                          return CustomUserDialog(userId: userId);
                        },
                      );
                    },
                    child: const Icon(Icons.account_circle, color: Colors.white, size: 40),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text("Usuario123", style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.05), // 5% de la altura total de la pantalla
            Expanded(
              child: Image.asset('assets/images/camioneta.png', fit: BoxFit.contain),
            ),
            SizedBox(height: size.height * 0.01), // 1% de la altura total de la pantalla
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1), // 10% del ancho de la pantalla
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Vehículo", style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 25)),
                    SizedBox(height: 10),
                    Text("Toyota Tacoma", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 5),
                    Text("CJ CH 25", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05), // 5% de la altura de la pantalla, espacio entre el cuadro y la barra
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Color(0xFF677191),
        shape: CircularNotchedRectangle(),
        notchMargin: -100,  // Corregido para ajustar visualmente la interfaz
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: size.height * 0.1), // 10% del alto de la pantalla para mover el botón hacia abajo
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SelectCampusPage(userId: userId, vehicleid: vehicleid)),
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