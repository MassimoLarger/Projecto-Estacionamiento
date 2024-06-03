import 'package:flutter/material.dart';
import 'verificaciones/cerrar_sesion.dart';
import 'editar_perfil.dart';

class CustomUserDialog extends StatelessWidget {
  const CustomUserDialog({super.key});

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
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 40,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(height: 10),
                  const Text('Usuario123', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Detalles Personales'),
                    onTap: () {
                      // Acción
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Contraseña y seguridad'),
                    onTap: () {
                      // Acción
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