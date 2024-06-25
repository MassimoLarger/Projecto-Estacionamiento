import 'package:flutter/material.dart';
import 'chuyaca.dart';
import 'meyer.dart';
import 'usuario.dart';

class GuardiaScreen extends StatelessWidget {
  const GuardiaScreen({super.key});

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
                    builder: (context) => const CustomUserDialog(),
                    barrierColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),  // Ajusta esto para cambiar el color y la opacidad
                  );
                },
                child: const Icon(Icons.account_circle, color: Colors.white, size: 40),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text("Guardia123", style: TextStyle(color: Colors.white, fontSize: 20)),
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
                  showSedeChuyacaSelector(context);
                }),
                campusCard('Meyer', 'assets/images/meyer.png', context, screenWidth/ 1, () {
                  showSedeMeyerSelector(context);
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

  void showSedeChuyacaSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const SedeChuyacaSelector();
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
    );
  }

  void showSedeMeyerSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const SedeMeyerSelector();
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
    );
  }
}
