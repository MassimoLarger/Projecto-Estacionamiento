import 'package:flutter/material.dart';
import 'verificaciones/verificacion2.dart';  // Ensure this path is correct based on your project structure.

class RecuperarContraScreen extends StatelessWidget {
  RecuperarContraScreen({super.key});

  // Controller for the phone number input field.
  final TextEditingController phoneController = TextEditingController();

void _showConfirmationDialog(BuildContext context, String phoneNumber) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  // Process the phone number to display only the last two digits.
  String processedPhoneNumber = phoneNumber.length > 8
      ? "${phoneNumber.substring(0, phoneNumber.length - 8)}******${phoneNumber.substring(phoneNumber.length - 2)}"
      : phoneNumber;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Container(
              width: width * 0.2,
              height: width * 0.2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(43, 220, 61, 1),
              ),
              child: const Center(
                child: Icon(Icons.check, size: 60, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              child: Text(
                "Enviamos un SMS a +$processedPhoneNumber.\nIngresa a tu casilla de mensajes y sigue las instrucciones para continuar con la recuperación de la contraseña.",
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Cerrar el diálogo primero
                  Navigator.of(context).pop();

                  // Navegar a la pantalla de verificación
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => VerifyPhoneContraScreen(phoneNumber: phoneNumber)
                    )
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 15),
                ),
                child: const Text("OK", style: TextStyle(color: Colors.white)),
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
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: screenSize.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: const Text(
                'Recuperar contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Luckiest Guy',
                  color: Color(0xFF273BF4),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset('assets/images/inicio.png', height: screenSize.height * 0.3),
            SizedBox(height: screenSize.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Text(
                'Ingresa tu número de teléfono para recuperar tu contraseña',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: const Color(0xFF192342),
                  fontSize: screenSize.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Número de Teléfono', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: 'Ej: 569########',
                      prefixIcon: const Icon(Icons.phone_android),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(198, 212, 255, 1),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showConfirmationDialog(context, phoneController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF567DF4),
                      foregroundColor: Colors.white,
                      minimumSize: Size(screenSize.width * 0.90, 50),
                    ),
                    child: const Text('Enviar SMS'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}