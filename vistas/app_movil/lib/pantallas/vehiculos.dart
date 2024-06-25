import 'package:flutter/material.dart';

class MisVehiculosScreen extends StatefulWidget {
  final String userId;

  const MisVehiculosScreen({Key? key, required this.userId}) : super(key: key);

  @override
  MisVehiculosScreenState createState() => MisVehiculosScreenState();
}

class MisVehiculosScreenState extends State<MisVehiculosScreen> {
  
  List<Map<String, String>> vehiculos = [
    {
      'modelo': 'Toyota Tacoma',
      'patente': 'CJ CH 25',
    },
    {
      'modelo': 'Nissan Sentra',
      'patente': 'AB CD 12',
    },
    // Añadir más vehículos si es necesario
  ];

  void _showConfirmationDialog(int index) {
    double width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "¿Estás seguro que deseas eliminar este vehículo?",
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: width * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      vehiculos.removeAt(index);
                      Navigator.of(context).pop();
                    });
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
                    Navigator.of(context).pop();
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

  // Método para abrir el diálogo de agregar vehículo
  void _agregarVehiculoDialog() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontSize = screenWidth * 0.045;
    double labelFontSize = screenWidth * 0.04;

    TextEditingController modeloController = TextEditingController();
    TextEditingController patenteController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            'Agregar Vehículo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
              fontSize: fontSize,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alineación del contenido a la izquierda
              children: <Widget>[
                Text(
                  'Modelo del Vehículo',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: labelFontSize,
                  ),
                ),
                TextFormField(
                  controller: modeloController,
                  decoration: const InputDecoration(
                    //hintText: 'Ingrese el modelo del vehículo',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Patente del Vehículo',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: labelFontSize,
                  ),
                ),
                TextFormField(
                  controller: patenteController,
                  decoration: const InputDecoration(
                    //hintText: 'Ingrese la patente del vehículo',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    vehiculos.add({
                      'modelo': modeloController.text,
                      'patente': patenteController.text,
                    });
                    Navigator.of(context).pop();
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF567DF4),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.02),
                ),
                child: Text('Agregar', style: TextStyle(fontSize: fontSize)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.06;
    double listTitleFontSize = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tus Vehículos',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: vehiculos.length + 1, // +1 para incluir el botón de agregar
              itemBuilder: (context, index) {
                if (index == vehiculos.length) {
                  // Agregar botón al final de la lista
                  return ListTile(
                    title: Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFF567DF4),
                        child: IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: _agregarVehiculoDialog,
                        ),
                      ),
                    ),
                  );
                }
                return ListTile(
                  title: Text(
                    vehiculos[index]['modelo'] ?? '',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: listTitleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text('Patente: ${vehiculos[index]['patente']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _showConfirmationDialog(index),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
