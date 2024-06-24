import 'package:flutter/material.dart';
import 'usuario.dart';
import 'modificar_reserva_1.dart';

class EspacioEstacionamientoWidget extends StatefulWidget {
  final String sectionName;
  final String sedeName;

  const EspacioEstacionamientoWidget({super.key, required this.sectionName, required this.sedeName});

  @override
  EspacioEstacionamientoWidgetState createState() => EspacioEstacionamientoWidgetState();
}

class EspacioEstacionamientoWidgetState extends State<EspacioEstacionamientoWidget> {
  int espaciosDisponibles = 0;  // Iniciar con cero
  int espaciosReservados = 0;   // Iniciar con cero

  @override
  void initState() {
    super.initState();
    updateParkingData();
  }

  void updateParkingData() {
    // Lógica para determinar los espacios disponibles y reservados
    if (widget.sedeName == "Meyer" && widget.sectionName == "Entrada") {
      espaciosDisponibles = 8;
      espaciosReservados = 2;
    } else {
      espaciosDisponibles = 6;  // Valores predeterminados
      espaciosReservados = 14;
    }
    // Añadir más condiciones según la configuración de tu aplicación
  }

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
                  return const CustomUserDialog();
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
            child: Text(
              'Estacionamiento ${widget.sectionName}',  // Usar la sección dinámica
              style: const TextStyle(
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
              child: Image.asset('assets/images/estacionamiento.png', fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildParkingStatusIndicator('Disponibles', espaciosDisponibles, const Color(0xFF2957C2), const Color(0xFF2957C2)),
              _buildParkingStatusIndicator('Reservados', espaciosReservados, Colors.red, Colors.red),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.1),
            child: SizedBox(
              width: screenWidth * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DetailScreen1()),
                  );
                },                
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5)
                  )
                ),
                child: const Text(
                  'Continuar',
                  style: TextStyle(fontSize: 16, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParkingStatusIndicator(String title, int count, Color borderColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 5),
          Text(
            '$count',
            style: TextStyle(fontSize: 15, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }
}
