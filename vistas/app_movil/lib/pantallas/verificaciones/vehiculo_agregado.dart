import 'package:flutter/material.dart';
import '../patentes.dart';

class VehiculoAgregadoWidget extends StatefulWidget {
  final String userId;
  final int vehicleType;
  const VehiculoAgregadoWidget({Key? key, required this.userId,
    required this.vehicleType}) : super(key: key);

  @override
  VehiculoAgregadoWidgetState createState() => VehiculoAgregadoWidgetState();
}

class VehiculoAgregadoWidgetState extends State<VehiculoAgregadoWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => PatentesPage(userId: widget.userId, vehicleType: widget.vehicleType)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(86, 125, 244, 1),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenWidth * 0.4,
                height: screenWidth * 0.4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(43, 220, 61, 1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    size: 100,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              const Text(
                'Operación\nExitosa!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 48,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 250),
                child: Text(
                  'Tu vehículo ha sido agregado.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
