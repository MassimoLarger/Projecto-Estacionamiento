import 'package:flutter/material.dart';

class SedeMeyerSelector extends StatefulWidget {
  const SedeMeyerSelector({super.key});
  @override
  SedeMeyerSelectorState createState() => SedeMeyerSelectorState();
}

class SedeMeyerSelectorState extends State<SedeMeyerSelector> {
  int _selectedIndex = -1;

  final List<Map<String, dynamic>> places = [
    {'name': 'Entrada'},
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
          SizedBox(height: scaleText(20)), // Dynamically scaled vertical space
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05), // 5% of total width
            child: Text(
              "SELECCIONA EL LUGAR",
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: scaleText(16), // Dynamically scaled font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: scaleText(18)), // More dynamically scaled vertical space
          Padding(  // Added padding to align with the text above
            padding: EdgeInsets.symmetric(horizontal: width * 0.05), // 5% of total width
            child: SizedBox(
              height: 170, // Specifies the height of the horizontal list
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
                      //Navigator.push(
                        //context,
                        //MaterialPageRoute(builder: (context) => const BookingScreen()),
                      //);
                    },
                    child: SizedBox(
                      width: width * 0.9, // 40% of the screen width
                      child: Card(
                        color: isSelected ? const Color(0xFF567DF4) : const Color(0xFFB7C7F9),
                        child: ListTile(
                            title: Text(
                              places[index]['name'],
                              style: TextStyle(
                                fontSize: scaleText(20), // Dynamically scaled font size
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
  }
}