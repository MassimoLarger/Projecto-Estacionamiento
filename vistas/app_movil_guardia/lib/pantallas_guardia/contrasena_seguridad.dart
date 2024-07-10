import 'package:flutter/material.dart';
import 'verificaciones/cambiar_contra_exitoso.dart';
import 'verificaciones/cambiar_contra_erroneo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PasswordAndSecurityPage extends StatefulWidget {
  final String userId;
  final String userPassword;

  const PasswordAndSecurityPage({Key? key, required this.userId, required this.userPassword}) : super(key: key);

  @override
  _PasswordAndSecurityPageState createState() => _PasswordAndSecurityPageState();
}

class _PasswordAndSecurityPageState extends State<PasswordAndSecurityPage> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();

  void _showConfirmationDialog(BuildContext context, String newPassword) async {
    double width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "¿Estás seguro que deseas confirmar tu nueva contraseña?",
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
                  onPressed: () async {
                    Navigator.pop(context);
                    await _updatePassword(newPassword);
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
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

  Future<void> _updatePassword(String newPassword) async {
    final response = await http.post(
      Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/actualizar_contrasena'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': widget.userId,
        'newPassword': newPassword,
        'newPassword_verify': verifyPasswordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['success']) {
        showDialog(
          context: context,
          builder: (_) => ContrasenaCambiadaExitoWidget(userId: widget.userId, userPassword: newPassword),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => ContrasenaCambiadaErrorWidget(userId: widget.userId, userPassword: newPassword),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cambiar la contraseña')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double titleFontSize = screenWidth < 600 ? 20 : 24;
    double subTitleFontSize = screenWidth < 600 ? 16 : 18;
    double buttonPaddingHorizontal = screenWidth < 360 ? 20 : 87;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(screenWidth * 0.04),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                child: Text(
                  'Cambiar Contraseña',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Text(
              'Contraseña Actual',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: subTitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Text(
                widget.userPassword,
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: subTitleFontSize,
                ),
              ),
            ),
            const Divider(),
            Text(
              'Nueva Contraseña',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: subTitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Ingrese su nueva contraseña',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Verifique su Nueva Contraseña',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: subTitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: verifyPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Verifique su nueva contraseña',
              ),
            ),
            const Divider(),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.035),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: buttonPaddingHorizontal, vertical: 15),
                  ),
                  onPressed: () {
                    if (newPasswordController.text == verifyPasswordController.text) {
                      _showConfirmationDialog(context, newPasswordController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Las contraseñas no coinciden')),
                      );
                    }
                  },
                  child: const Text('Cambiar Contraseña'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}