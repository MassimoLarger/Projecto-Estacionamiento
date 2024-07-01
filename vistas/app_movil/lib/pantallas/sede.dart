import 'package:flutter/material.dart';
import 'usuario.dart';
import 'agenda_reserva.dart';

class SelectCampusPage extends StatelessWidget {
  final String userId;
  final String vehicleid;

  const SelectCampusPage({Key? key, required this.userId, required this.vehicleid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return CustomUserDialog(userId: userId);
                },
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Seleccione la Sede\ndonde quiere reservar',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          campusCard('Chuyaca', 'assets/images/chuyaca.png', context, screenWidth, () {
            _showPlaceSelectionSheet(context, userId, vehicleid, 'Chuyaca');
          }),
          campusCard('Meyer', 'assets/images/meyer.png', context, screenWidth, () {
            _showPlaceSelectionSheet(context, userId, vehicleid, 'Meyer');
          }),
        ],
      ),
    );
  }

  Widget campusCard(String campusName, String imagePath, BuildContext context, double screenWidth, VoidCallback onPressed) {
    return Column(
      children: <Widget>[
        Image.asset(imagePath),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF567DF4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(27.5),
            ),
            fixedSize: Size(screenWidth * 0.8, 48),
          ),
          onPressed: onPressed,
          child: Text(
            campusName,
            style: const TextStyle(
              fontFamily: 'Lato',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  void _showPlaceSelectionSheet(BuildContext context, String userId, String vehicleid, String campus) {
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
                                  builder: (context) => BookingScreen(
                                    sectionName: places[index]['name'],
                                    sedeName: campus,
                                    userId: userId,
                                    vehicleid: vehicleid,
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
