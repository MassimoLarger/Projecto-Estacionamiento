import 'package:flutter/material.dart';
import 'verificaciones/eliminar_reserva_erroneo.dart';
import 'verificaciones/eliminar_reserva_exitoso.dart';
import 'usuario.dart';
import 'modificar_reserva.dart';


class DetailScreen1 extends StatelessWidget {
  const DetailScreen1({super.key});
 
  void _showEliminarReservaDialog(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: false,  // Esto evita que el diálogo se cierre al tocar fuera del cuadro
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "¿Estás seguro que deseas eliminar la reserva?",
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: width * 0.045,  // Escala el tamaño de la fuente basado en el ancho de la pantalla
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Centra los botones en el diálogo
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const EliminarReservaExitoWidget()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4), // Color azul claro para el botón
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 15),  // Padding relativo al ancho
                  ),
                  child: const Text("Sí", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const EliminarReservaErrorWidget()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4), // Mismo color para ambos botones
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 15),  // Padding relativo al ancho
                  ),
                  child: const Text("No", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Modificar reserva',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Lato'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(width * 0.07),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F6FF),
                borderRadius: BorderRadius.circular(0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailItem(title: 'VEHÍCULO', value: 'Toyota Tacoma • CJ CH 25'),
                  DetailItem(title: 'ESTACIONAMIENTO', value: 'Campus Chuyaca • Espacio AV01'),
                  DetailItem(title: 'HORA/FECHA', value: '16:00 - 17:00 PM • 25 Sep. 2024'),
                ],
              ),
            ),
            const SizedBox(height: 210),
            ButtonTheme(
              minWidth: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  minimumSize: Size(width, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                ),
                child: const Text('Editar Reserva', style: TextStyle(fontSize: 16, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BookingScreen()),
                  );
                }, 
              ),
            ),
            const SizedBox(height: 20),
            ButtonTheme(
              minWidth: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  minimumSize: Size(width, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                ),
                child: const Text('Eliminar Reserva', style: TextStyle(fontSize: 16, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: Colors.white)),
                onPressed: () => _showEliminarReservaDialog(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String title;
  final String value;

  const DetailItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.black54, fontSize: 16, fontFamily: 'Lato')),
        Text(value, style: const TextStyle(fontSize: 18, fontFamily: 'Lato')),
        const SizedBox(height: 10),
      ],
    );
  }
}