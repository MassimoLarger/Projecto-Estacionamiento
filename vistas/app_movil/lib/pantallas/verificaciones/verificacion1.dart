import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'codigo_verificado.dart';
import 'codigo_erroneo.dart';  // Asegúrate de crear esta pantalla

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  VerifyPhoneScreenState createState() => VerifyPhoneScreenState();
}

class VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController _pinController = TextEditingController();

  void verificarCodigo(String codigo) {
    const codigoCorrecto = "1234";  // Define el código correcto aquí
    if (codigo == codigoCorrecto) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CodigoVerificadoWidget()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CodigoVerificadoErrorWidget()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleTextStyle: const TextStyle(color: Colors.blue, fontSize: 20),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Image.asset('assets/images/logo2.png'),
              const SizedBox(height: 40),
              const Text(
                "Verificar número de teléfono",
                style: TextStyle(fontSize: 24, fontFamily: 'Lato', fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
              ),
              const SizedBox(height: 10),
              const Text(
                "Ingrese su código aquí",
                style: TextStyle(fontSize: 18, fontFamily: 'Lato', color: Colors.black),
              ),
              const SizedBox(height: 30),
              PinCodeTextField(
                appContext: context,
                length: 4,
                controller: _pinController,
                onChanged: (String value) {},
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeFillColor: Colors.blue[50],
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 170),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
                ),
                onPressed: () => verificarCodigo(_pinController.text),
                child: const Text("Verificar ahora"),
              )
            ],
          ),
        ),
      ),
    );
  }
}