import 'package:flutter/material.dart';

class ParkingScreen extends StatelessWidget {
  const ParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              child: const Text('Estacionamientos', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Lato')),
            ),
            const ParkingSection(title: 'Meyer', reserved: 12, available: 0, total: 12, titleFontSize: 25, titleColor: Color(0xFF5C5C5C)),  // Custom color
            const ParkingSection(title: 'Chuyaca', reserved: 300, available: 5, total: 500, titleFontSize: 25, titleColor: Color(0xFF5C5C5C)),  // Custom color
          ],
        ),
      ),
    );
  }
}

class ParkingSection extends StatelessWidget {
  final String title;
  final int reserved;
  final int available;
  final int total;
  final double titleFontSize;  // Font size parameter
  final Color titleColor;  // Color parameter

  const ParkingSection({
    super.key,
    required this.title,
    required this.reserved,
    required this.available,
    required this.total,
    this.titleFontSize = 16,  // Default font size if not provided
    this.titleColor = Colors.black,  // Default color if not provided
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;  // Get the width of the screen
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold, fontFamily: 'Lato', color: titleColor)),
          SizedBox(height: width * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ParkingInfo(color: const Color(0xFFFFECEF), textColor: const Color(0xFFDF1525), text: 'Reservados:', number: reserved, width: width * 0.25),
              ParkingInfo(color: const Color(0xFFF3F8FF), textColor: const Color(0xFF2957C2), text: 'Disponibles:', number: available, width: width * 0.25),
              ParkingInfo(color: const Color(0xFFD9D9D9), textColor: const Color.fromARGB(255, 0, 0, 0), text: 'Total:', number: total, width: width * 0.25),
            ],
          ),
        ],
      ),
    );
  }
}

class ParkingInfo extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final int number;
  final double width;  // Added to adapt to screen sizes

  const ParkingInfo({
    super.key,
    required this.color,
    required this.textColor,
    required this.text,
    required this.number,
    required this.width,  // Pass this as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(text, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Container(
          width: width,  // Use the passed width
          height: width * 2,  // Height relative to width
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Center(
            child: Text(number.toString(), style: const TextStyle(fontSize: 25, color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
