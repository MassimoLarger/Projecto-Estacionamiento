import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _rutController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white, // Fondo del Scaffold
      appBar: AppBar(
        backgroundColor: Colors.white, // Fondo de la AppBar
        elevation: 0, // Remueve la sombra bajo la AppBar
        iconTheme: const IconThemeData(color: Colors.black), // Iconos de la AppBar en negro para contraste
        titleTextStyle: TextStyle(color: Colors.black, fontSize: screenSize.width * 0.05), // Texto de la AppBar ajustado
      ),
      body: SingleChildScrollView( // Usa SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bienvenidos a Parking APP\nAdmin Ulagos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width * 0.06, // Ajuste dinámico del tamaño de fuente
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              Text(
                'Ingresa con tu cuenta y utiliza Parking APP Admin Ulagos',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: screenSize.width * 0.03, // Ajuste dinámico del tamaño de fuente
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rut', 
                  style: TextStyle(fontSize: screenSize.width * 0.035, fontWeight: FontWeight.bold, color: Colors.black)
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              TextField(
                controller: _rutController,
                decoration: InputDecoration(
                  hintText: '12.345.678-9',                
                  prefixIcon: const Icon(Icons.account_circle),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Color(0xFFF3F6FF), width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF3F6FF),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contraseña', 
                  style: TextStyle(fontSize: screenSize.width * 0.035, fontWeight: FontWeight.bold, color: Colors.black)
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Introduce tu contraseña',      
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Color(0xFFF3F6FF), width: 1.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF3F6FF),
                ),
                obscureText: true,
              ),
              SizedBox(height: screenSize.height * 0.35), // Espacio ajustable
              ElevatedButton(
                onPressed: () {
                  // Aquí manejas la lógica de inicio de sesión
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4), // Fondo del botón
                  minimumSize: Size(screenSize.width * 0.90, 50), // Hace que el botón sea tan ancho como el 90% del ancho de la pantalla
                ),
                child: Text('Iniciar Sesión', style: TextStyle(color: Colors.white, fontSize: screenSize.width * 0.04)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
