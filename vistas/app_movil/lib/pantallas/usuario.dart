import 'package:flutter/material.dart';
import 'verificaciones/cerrar_sesion.dart';
import 'editar_perfil.dart';
import 'dart:io';
import 'datos_personales.dart';
import 'vehiculos.dart';
import 'reservas.dart';
import 'contrasena_seguridad.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomUserDialog extends StatefulWidget {
  final String userId;

  const CustomUserDialog({Key? key, required this.userId}) : super(key: key);

  @override
  CustomUserDialogState createState() => CustomUserDialogState();
}

class CustomUserDialogState extends State<CustomUserDialog> {
  String userName = "";
  int userPhone = 0;
  String userType = "";
  String userPassword = "";
  File? userImage;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/consultau'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'correo': widget.userId,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['success']) {
          setState(() {
            userName = responseBody['usuario']['nombre'] ?? "";
            userPhone = responseBody['usuario']['telefono'] ?? 0;
            userType = responseBody['usuario']['tipo'] ?? "";
            userPassword = responseBody['usuario']['contrasena'] ?? "";
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody['message'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en la consulta al servidor')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showCerrarSesionDialog(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "¿Estás seguro que deseas cerrar sesión?",
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: width * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CerrarSesionWidget()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 15),
                  ),
                  child: const Text("Sí", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: 15),
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
          nombreInicial: userName,
        ),
      ),
    );

    if (result != null && result.containsKey('nombre')) {
      setState(() {
        isLoading = true;
      });

      String updatedName = result['nombre'];

      try {
        final response = await http.post(
          Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/updateProfile'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'correo': widget.userId,
            'nombre': updatedName,
          }),
        );

        if (response.statusCode == 200) {
          setState(() {
            userName = updatedName;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Perfil actualizado correctamente')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error al actualizar el perfil')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
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
        alignment: Alignment.topRight,
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
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
                        context,
                        MaterialPageRoute(builder: (context) => PersonalDetailsPage(userId: widget.userId, userPhone: userPhone, userType: userType)),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Contraseña y seguridad'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PasswordAndSecurityPage(userId: widget.userId, userPassword: userPassword)),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('Reservas'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReservasScreen(userId: widget.userId)),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.directions_car),
                    title: const Text('Tus vehículos'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MisVehiculosScreen(userId: widget.userId)),
                      );
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
          Positioned(
            right: 4,
            top: 4,
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