import 'package:flutter/material.dart';
import 'agenda_reserva.dart';

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
    // Agregar más lugares según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
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
                      if (isSelected) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingScreen(userId: widget.userId),
                          ),
                        );
                      }
                    },
                    child: Card(
                      color: isSelected ? const Color(0xFF567DF4) : const Color(0xFFB7C7F9),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              places[index]['name'],
                              style: TextStyle(
                                fontSize: scaleText(20),
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            if (isSelected)
                              Icon(Icons.check_box, color: Colors.white),
                          ],
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
  }
}