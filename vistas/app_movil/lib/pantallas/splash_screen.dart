import 'package:flutter/material.dart';
import 'pantallas/cargando.dart'; 
import 'pantallas/bienvenido.dart';  

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // Navega a BienvenidaWidget después de 3 segundos
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const InicioWidget()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mostrar CargandoWidget mientras espera
    return const CargandoWidget();
  }
}
