import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'tipo_de_cuenta.dart';
import 'recuperar_contrasena.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtiene las dimensiones de la pantalla para una adaptabilidad mejorada
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: screenSize.height * 0.05), // Usa un porcentaje de la altura de la pantalla
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: const Text(
                '¿Buscas un lugar para estacionarte?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Luckiest Guy',
                  color: Color(0xFF273BF4),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset('assets/images/inicio.png', height: screenSize.height * 0.3), // Ajusta la imagen al 30% de la altura de la pantalla
            SizedBox(height: screenSize.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Text(
                'Inicie sesión o regístrese en su cuenta de la aplicación Parking Ulagos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: const Color(0xFF192342),
                  fontSize: screenSize.width * 0.045, // Ajusta el tamaño de la fuente basado en el ancho de la pantalla
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
                    decoration: InputDecoration(
                      hintText: 'Introduce tu número de teléfono',
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
                  const Text('Contraseña', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Introduce tu contraseña',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Color.fromRGBO(198, 212, 255, 1), width: 1.0),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(198, 212, 255, 1),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.push(
                        //context,
                        //MaterialPageRoute(builder: (context) => const TipodecuentaWidget()),
                      //);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF567DF4),
                      foregroundColor: Colors.white,
                      minimumSize: Size(screenSize.width * 0.90, 50), // Hace que el botón sea tan ancho como el 85% del ancho de la pantalla
                    ),
                    child: const Text('Iniciar Sesión'),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: '¿No tienes cuenta? ',
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Crear Cuenta',
                            style: const TextStyle(
                              color: Color.fromRGBO(41, 87, 194, 1),
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const TipodecuentaWidget()));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: '¿Olvidaste la contraseña? ',
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Recupérala',
                            style: const TextStyle(
                              color: Color.fromRGBO(41, 87, 194, 1),
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RecuperarContraScreen()));
                              },
                          ),
                        ],
                      ),
                    ),
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
