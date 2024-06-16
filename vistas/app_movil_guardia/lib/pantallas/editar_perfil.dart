import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  final String nombreInicial;
  final File? imagenInicial;

  const EditProfilePage({
    super.key,  
    required this.nombreInicial, 
    this.imagenInicial
  });

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  File? _image;
  final ImagePicker picker = ImagePicker();
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    _image = widget.imagenInicial;
    nameController = TextEditingController(text: widget.nombreInicial);
  }

  Future getImage() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

void _showConfirmationDialog(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  showDialog(
    context: context,
    barrierDismissible: false,  // Esto evita que el diálogo se cierre al tocar fuera del cuadro
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: Text(
          "¿Estás seguro que deseas confirmar los cambios?",
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
                  Navigator.pop(context);  // Cierra el diálogo
                  Navigator.pop(context, {'nombre': nameController.text, 'imagen': _image});  // Devuelve los datos actualizados
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
                  Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    // Obtiene las dimensiones de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => _showConfirmationDialog(context),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05), // Usa un porcentaje del ancho de la pantalla
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Editar perfil',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: screenWidth * 0.06, // Escala el tamaño del texto según el ancho de la pantalla
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: screenWidth * 0.15, // Hace que el radio del avatar sea proporcional al ancho de la pantalla
                  backgroundColor: Colors.grey,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(Icons.add_a_photo, size: screenWidth * 0.1) // Ajusta el tamaño del icono según el ancho de la pantalla
                      : null,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
