import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});
  @override
  BookingScreenState createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedTime;

  void _selectDate(BuildContext context) async {
    final ThemeData datePickerTheme = ThemeData.light().copyWith(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF567DF4),
        onPrimary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      dialogBackgroundColor: Colors.white,
    );

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale('es', 'ES'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: datePickerTheme,
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              // Implement navigation to user profile
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              'Agendar Reserva',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Selecciona la fecha y hora',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Text('Fecha', style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F8FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Color(0xFF0C41FF)),
                  const SizedBox(width: 10),
                  Text(DateFormat('dd/MM/yyyy').format(selectedDate)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Horarios', style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.bold)),
          const Text('Mañana', style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.normal)),
          TimeButtonGroup(times: const ['08:00', '08:45', '09:30', '10:15', '11:00', '11:45', '12:30'], selectedTime: selectedTime, onTimeSelected: (time) => setState(() => selectedTime = time)),
          const Text('Tarde', style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.normal)),
          TimeButtonGroup(times: const ['13:15', '14:00', '14:45', '15:30', '16:15', '17:00', '17:45', '18:30'], selectedTime: selectedTime, onTimeSelected: (time) => setState(() => selectedTime = time)),
          const Text('Noche', style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.normal)),
          TimeButtonGroup(times: const ['19:15', '20:00', '20:45', '21:30', '22:15', '23:00', '23:45'], selectedTime: selectedTime, onTimeSelected: (time) => setState(() => selectedTime = time)),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const VehiculoAgregadoWidget()),
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF567DF4),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Reservar'),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeButtonGroup extends StatelessWidget {
  final List<String> times;
  final String? selectedTime;
  final Function(String) onTimeSelected;

  const TimeButtonGroup({
    super.key,
    required this.times,
    this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: times.map((time) {
        bool isSelected = selectedTime == time;
        return ChoiceChip(
          label: Text(time),
          selected: isSelected,
          onSelected: (bool selected) {
            onTimeSelected(time);
          },
          backgroundColor: const Color(0xFFF3F8FF),
          selectedColor: isSelected ? const Color(0xFF567DF4) : Colors.transparent,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF677191),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }).toList(),
    );
  }
}