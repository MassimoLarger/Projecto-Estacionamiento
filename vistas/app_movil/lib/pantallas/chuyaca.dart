import 'package:flutter/material.dart';
import 'espacios_estacionamiento.dart'; // Asegúrate de tener el import correcto

class SedeChuyacaSelector extends StatefulWidget {
  final String userId;

  const SedeChuyacaSelector({Key? key, required this.userId}) : super(key: key);

  @override
  SedeChuyacaSelectorState createState() => SedeChuyacaSelectorState();
}

class SedeChuyacaSelectorState extends State<SedeChuyacaSelector> {
  int _selectedIndex = -1;

  final List<Map<String, dynamic>> places = [
    {'name': 'Entrada'},
    {'name': 'Gym'},
    {'name': 'Aulas Virtuales'},
    {'name': 'Casino'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPlaceSelectionSheet();
    });
  }

  void _showPlaceSelectionSheet() {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.2), // Fondo ligeramente oscuro
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        double width = MediaQuery.of(context).size.width;
        double scaleText(double size) => size * MediaQuery.textScaleFactorOf(context);

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
                                //sectionName: places[index]['name'],
                                //sedeName: 'Chuyaca',
                                userId: widget.userId,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: width * 0.9,
                          child: Card(
                            color: isSelected
                                ? const Color(0xFF567DF4)
                                : const Color(0xFFB7C7F9),
                            child: ListTile(
                              title: Text(
                                places[index]['name'],
                                style: TextStyle(
                                  fontSize: scaleText(20),
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                              trailing: isSelected
                                  ? const Icon(Icons.check_box, color: Colors.white)
                                  : null,
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
    ).whenComplete(() {
      // Navigate back when the modal is dismissed
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Return an empty container as the modal will be shown automatically
  }
}