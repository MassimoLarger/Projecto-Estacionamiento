import 'package:flutter/material.dart';
import 'verificaciones/cambiar_contra_exitoso.dart';
import 'verificaciones/cambiar_contra_erroneo.dart';

class PasswordAndSecurityPage extends StatelessWidget {
  const PasswordAndSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dimensiones de la pantalla para diseños responsivos
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adaptar tamaños de fuente según el tamaño de la pantalla
    double titleFontSize = screenWidth < 600 ? 20 : 24; // Menor para teléfonos, mayor para tablets
    double subTitleFontSize = screenWidth < 600 ? 16 : 18;
    double buttonPaddingHorizontal = screenWidth < 360 ? 20 : 87; // Menos padding en pantallas muy pequeñas

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0, // Remover sombra
      ),
      body: Container(
        width: double.infinity, // Asegura que el Container tome todo el ancho disponible
        padding: EdgeInsets.all(screenWidth * 0.04), // Padding proporcional al ancho de la pantalla
        color: const Color.fromARGB(255, 255, 255, 255), // Establece el color de fondo de la página
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                child: Text(
                  'Contraseña y Seguridad',
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
              'Contraseña',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: subTitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Text(
                '**********',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: subTitleFontSize,
                ),
              ),
            ),
            const Divider(),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.035),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF567DF4), // Background color
                    foregroundColor: Colors.white, // Text Color (Foreground color)
                    padding: EdgeInsets.symmetric(horizontal: buttonPaddingHorizontal, vertical: 15), // Adaptativo
                  ),
                  onPressed: () => _showChangePasswordDialog(context),
                  child: const Text('Cambiar contraseña'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

void _showChangePasswordDialog(BuildContext context) {
  // Obtener dimensiones de la pantalla para ajustes responsivos
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  // Escalar los tamaños de fuente basados en la anchura de la pantalla
  double fontSize = screenWidth < 360 ? 16 : (screenWidth < 600 ? 18 : 20);
  double labelFontSize = screenWidth < 360 ? 14 : (screenWidth < 600 ? 16 : 18);
  double buttonPaddingHorizontal = screenWidth < 360 ? 20 : 40;
  double buttonPaddingVertical = screenHeight < 600 ? 10 : 12;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController newPasswordController = TextEditingController();
      TextEditingController confirmNewPasswordController = TextEditingController();

      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(
          'Cambio de Contraseña',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: fontSize, // Tamaño de fuente ajustado
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nueva Contraseña',
                  floatingLabelBehavior: FloatingLabelBehavior.always, 
                  labelStyle: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: labelFontSize, // Tamaño de fuente ajustado para label
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: labelFontSize),
              ),
              SizedBox(height: screenHeight * 0.03), // Espaciado ajustado
              TextFormField(
                controller: confirmNewPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar nueva Contraseña',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: labelFontSize, // Tamaño de fuente ajustado para label
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: labelFontSize),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF567DF4),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: buttonPaddingHorizontal, vertical: buttonPaddingVertical), // Padding ajustado
            ),
            onPressed: () {
              if (newPasswordController.text == confirmNewPasswordController.text) {
                Navigator.of(context).pop();
                _showConfirmationDialog2(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Las contraseñas no coinciden')),
                );
              }
            },
            child: const Text('Confirmar Contraseña'),
          ),
        ],
      );
    },
  );
}



  void _showConfirmationDialog2(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: false,  // Esto evita que el diálogo se cierre al tocar fuera del cuadro
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "¿Estás seguro que deseas confirmar tu nueva contraseña?",
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ContrasenaCambiadaExitoWidget()));
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
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ContrasenaCambiadaErrorWidget()));
                  },
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
}
