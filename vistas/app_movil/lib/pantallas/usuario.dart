import 'package:flutter/material.dart';
import 'verificaciones/cerrar_sesion.dart';
import 'editar_perfil.dart';
import 'dart:io';
import 'datos_personales.dart';
import 'contrasena_seguridad.dart';

class CustomUserDialog extends StatefulWidget {
  const CustomUserDialog({super.key});

  @override
  CustomUserDialogState createState() => CustomUserDialogState();
}
class CustomUserDialogState extends State<CustomUserDialog> {
  String userName = "Usuario123";  // Valor inicial, considera cambiarlo según tu lógica de negocio
  File? userImage;

  void _showCerrarSesionDialog(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: false,  // Esto evita que el diálogo se cierre al tocar fuera del cuadro
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "¿Estás seguro que deseas cerrar sesión?",
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const CerrarSesionWidget()));
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
                  onPressed: () => Navigator.of(context).pop(),
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

  void _openEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          nombreInicial: userName,  // pasa el nombre actual
          imagenInicial: userImage,  // pasa la imagen actual si la hay
        ),
      ),
    );

    if (result != null && result.containsKey('nombre') && result.containsKey('imagen')) {
      setState(() {
        userName = result['nombre'];
        userImage = result['imagen'] as File?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 16,
      backgroundColor: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topRight, // Alinea los elementos secundarios a la esquina superior derecha
        children: <Widget>[
          SingleChildScrollView( // Hace que el contenido sea desplazable
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20), // Ajusta el padding para evitar desbordamientos
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 40,
                    backgroundImage: userImage != null ? FileImage(userImage!) : null,
                    child: userImage == null ? const Icon(Icons.person, size: 40) : null,
                  ),
                  const SizedBox(height: 10),
                  Text(userName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: _openEditProfile,
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Detalles Personales'),
                    onTap: () {
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const PersonalDetailsPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Contraseña y seguridad'),
                    onTap: () {
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const PasswordAndSecurityPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('Reservas'),
                    onTap: () {
                      // Acción
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.directions_car),
                    title: const Text('Tus vehículos'),
                    onTap: () {
                      // Acción
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Ayuda'),
                    onTap: () {
                      // Acción
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.comment),
                    title: const Text('Comentarios'),
                    onTap: () {
                      // Acción
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Cerrar Sesión'),
                    onTap: () => _showCerrarSesionDialog(context),
                  ),
                ],
              ),
            ),
          ),
          Positioned( // Posicionamiento absoluto para la 'X'
            right: 4, // Posición desde la derecha
            top: 4, // Posición desde arriba
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}