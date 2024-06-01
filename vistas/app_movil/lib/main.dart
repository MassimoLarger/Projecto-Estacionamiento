import 'package:flutter/material.dart';
import 'pantallas/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Parking App Ulagos',
      home: SplashScreen(),  // Usando CargandoWidget aquí
    );
  }
}