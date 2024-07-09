import 'package:flutter/material.dart';
import 'usuario.dart';
import 'espacios_estacionamiento.dart';

class GuardiaScreen extends StatelessWidget {
  final String userId; // Cambiado a String

  const GuardiaScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF677191),
        automaticallyImplyLeading: false,
        elevation: 0,  // Eliminar cualquier sombra por debajo del AppBar.
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          color: const Color(0xFF677191), // Asegúrate de que el color llene todo el AppBar.
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomUserDialog(userId: userId), // Pasar el userId al diálogo
                    barrierColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),  // Ajusta esto para cambiar el color y la opacidad
                  );
                },
                child: const Icon(Icons.account_circle, color: Colors.white, size: 40),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(userId, style: const TextStyle(color: Colors.white, fontSize: 20)), // Mostrar el userId como nombre del guardia
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/images/guardia.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
              children: [
                campusCard('Chuyaca', 'assets/images/chuyaca.png', context, screenWidth /1, () {
                  _showPlaceSelectionSheet(context, userId, 'Chuyaca');
                }),
                campusCard('Meyer', 'assets/images/meyer.png', context, screenWidth/ 1, () {
                  _showPlaceSelectionSheet(context, userId, 'Meyer');
                }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF677191),
        shape: const CircularNotchedRectangle(),
        notchMargin: -100,
        elevation: 0,
        child: Container(height: 50),  // Adjust the height to ensure buttons fit well
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09), // Adjust padding to position the FABs correctly
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // This will place the FABs evenly spaced from each other
          children: [
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                // Acción para el botón Home
              },
              backgroundColor: const Color(0xFF456EFF),
              child: const Icon(Icons.home, color: Colors.white,size: 40),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                // Acción para el botón Add
              },
              backgroundColor: const Color(0xFF456EFF),
              child: const Icon(Icons.add, color: Colors.white,size: 40),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // This positions the FABs in the center docked to the BottomAppBar
    );
  }

  Widget campusCard(String campusName, String imagePath, BuildContext context, double screenWidth, VoidCallback onPressed) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Agrega un margen para evitar que el borde toque los bordes de otros elementos
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), // Bordes redondeados para la imagen
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8), // Asegura que la imagen también tenga bordes redondeados
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: screenWidth - 40, // Ajusta el ancho con respecto al padding general
              height: (screenWidth - 40) / 2, // Mantiene la proporción original
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF567DF4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27.5),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 64),
          ),
          onPressed: onPressed,
          child: Text(
            campusName,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _showPlaceSelectionSheet(BuildContext context, String userId, String campus) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        double width = MediaQuery.of(context).size.width;
        double scaleText(double size) => size * MediaQuery.textScaleFactorOf(context);

        int _selectedIndex = -1;
        final List<Map<String, dynamic>> places = (campus == 'Chuyaca')
            ? [
          {'name': 'Entrada C'},
          {'name': 'Gym'},
          {'name': 'Aulas Virtuales'},
          {'name': 'Casino'},
        ]
            : [
          {'name': 'Entrada M'}, // Ejemplo con una sola entrada
        ];

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SizedBox(
                      height: 4,
                      width: 40,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: scaleText(20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Text(
                      "SELECCIONA EL LUGAR",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: scaleText(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: scaleText(18)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          bool isSelected = _selectedIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EspacioEstacionamientoWidget(
                                    sectionName: places[index]['name'],
                                    sedeName: campus,
                                    userId: userId,
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: width * 0.9,
                              child: Card(
                                color: isSelected ? const Color(0xFF567DF4) : const Color(0xFFB7C7F9),
                                child: ListTile(
                                  title: Text(
                                    places[index]['name'],
                                    style: TextStyle(
                                      fontSize: scaleText(20),
                                      color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  trailing: isSelected ? const Icon(Icons.check_box, color: Colors.white) : null,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      // Do something if needed when the modal is dismissed
    });
  }
}