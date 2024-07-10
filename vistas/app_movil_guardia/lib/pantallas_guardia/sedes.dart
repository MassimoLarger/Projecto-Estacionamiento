import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'usuario.dart';
import 'espacios_estacionamiento.dart';

class GuardiaScreen extends StatefulWidget {
  final String userId;

  const GuardiaScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _GuardiaScreenState createState() => _GuardiaScreenState();
}

class _GuardiaScreenState extends State<GuardiaScreen> {
  String? guardName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGuardName(widget.userId);
  }

  Future<void> _fetchGuardName(String userId) async {
    try {
      final response = await http.post(
        Uri.parse('https://proyecto-estacionamiento-dy1e.onrender.com/api/consultan'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'correo': userId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success']) {
          setState(() {
            guardName = responseData['nombre'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            // Handle the error message as needed
          });
        }
      } else {
        setState(() {
          isLoading = false;
          // Handle the request error as needed
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        // Handle the exception as needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF677191),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          color: const Color(0xFF677191),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomUserDialog(userId: widget.userId),
                    barrierColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
                  );
                },
                child: const Icon(Icons.account_circle, color: Colors.white, size: 40),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  guardName ?? 'Nombre no encontrado',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
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
                campusCard('Chuyaca', 'assets/images/chuyaca.png', context, screenWidth / 1, () {
                  _showPlaceSelectionSheet(context, widget.userId, 'Chuyaca');
                }),
                campusCard('Meyer', 'assets/images/meyer.png', context, screenWidth / 1, () {
                  _showPlaceSelectionSheet(context, widget.userId, 'Meyer');
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
        child: Container(height: 50),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.09),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                // Acción para el botón Home
              },
              backgroundColor: const Color(0xFF456EFF),
              child: const Icon(Icons.home, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                // Acción para el botón Add
              },
              backgroundColor: const Color(0xFF456EFF),
              child: const Icon(Icons.add, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget campusCard(String campusName, String imagePath, BuildContext context, double screenWidth, VoidCallback onPressed) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: screenWidth - 40,
              height: (screenWidth - 40) / 2,
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
          {'name': 'Entrada M'},
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