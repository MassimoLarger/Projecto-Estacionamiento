import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'usuario.dart';
import 'espacios_estacionamiento.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});
  @override
  BookingScreenState createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedPeriod; // Mañana, Tarde, Noche
  TimeOfDay? timeFrom;
  TimeOfDay? timeTo;

  // Definir colores para cada período
  final Map<String, Color> periodColors = {
    'Mañana': const Color(0xFFF3F8FF),  
    'Tarde': const Color(0xFFF3F8FF),  
    'Noche': const Color(0xFFF3F8FF),  
  };

  final Map<String, List<String>> timeSlots = {
    'Mañana': List.generate(36, (index) {
      int hours = (index * 10 / 60 + 6).toInt();
      int minutes = (index * 10 % 60);
      if (hours == 24) hours = 0; // Cambia 24:00 a 00:00
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    }),
    'Tarde': List.generate(48, (index) {
      int hours = (index * 10 / 60 + 12).toInt();
      int minutes = (index * 10 % 60);
      if (hours == 24) hours = 0; // Cambia 24:00 a 00:00
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    }),
    'Noche': List.generate(25, (index) {
      int hours = (index * 10 / 60 + 20).toInt();
      int minutes = (index * 10 % 60);
      if (hours == 24) hours = 0; // Cambia 24:00 a 00:00
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    }),
  };

  final Map<String, Color> selectedPeriodColors = {
    'Mañana': const Color(0xFFC6D4FF),  // Color azul oscuro cuando seleccionado
    'Tarde': const Color(0xFFC6D4FF),  // Color naranja oscuro cuando seleccionado
    'Noche': const Color(0xFFC6D4FF),  // Color púrpura oscuro cuando seleccionado
  };

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

void _showTimeSelection(BuildContext context, {required bool isStartTime}) {
  final times = timeSlots[selectedPeriod] ?? []; // Usa la lista basada en el período seleccionado
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              isStartTime ? "Seleccione hora de inicio" : "Seleccione hora de fin", // Cambia el título basado en el contexto
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: times.length,
                itemBuilder: (BuildContext context, int index) {
                  bool isSelected = (isStartTime ? timeFrom : timeTo) != null &&
                      (isStartTime ? timeFrom : timeTo)!.hour == int.parse(times[index].split(':')[0]) &&
                      (isStartTime ? timeFrom : timeTo)!.minute == int.parse(times[index].split(':')[1]);
                  return ElevatedButton(
                    onPressed: () {
                      final parts = times[index].split(':');
                      final hour = int.parse(parts[0]);
                      final minute = int.parse(parts[1]);
                      final timeOfDay = TimeOfDay(hour: hour, minute: minute);
                      setState(() {
                        if (isStartTime) {
                          timeFrom = timeOfDay;
                        } else {
                          timeTo = timeOfDay;
                        }
                      });
                      Navigator.pop(context); // Cerrar el modal al seleccionar
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? const Color(0xFFC6D4FF) : const Color(0xFFF3F8FF), // Cambia el color si está seleccionado
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      times[index],
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const CustomUserDialog();
                },
              );
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
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
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat('dd/MMM/yyyy').format(selectedDate), style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Icon(Icons.calendar_today, color: Color(0xFF567DF4)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Horario', style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 39,
            children: ['Mañana', 'Tarde', 'Noche'].map((period) {
              return ChoiceChip(
                label: Text(period),
                selected: selectedPeriod == period,
                onSelected: (selected) {
                  setState(() => selectedPeriod = period);
                },
                backgroundColor: selectedPeriod == period ? selectedPeriodColors[period] : periodColors[period],
                selectedColor: selectedPeriodColors[period],
                labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              );
            }).toList(),
          ),
          // Elemento 'Desde'
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Desde',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => _showTimeSelection(context, isStartTime: true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3F8FF),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      timeFrom?.format(context) ?? 'Elige hora',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Elemento 'Hasta'
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Hasta',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => _showTimeSelection(context, isStartTime: false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3F8FF),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      timeTo?.format(context) ?? 'Elige hora',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 210),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EspacioEstacionamientoWidget()),
                );
              },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF567DF4), // Botón azul
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 16),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27.5)),
            ),
            child: const Text(
              'Reservar',
              style: TextStyle(
                fontFamily: 'Lato', 
                color: Color.fromARGB(255, 255, 255, 255), // Color del texto
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )   
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
      runSpacing: 8,
      children: times.map((time) {
        bool isSelected = selectedTime == time;
        return ChoiceChip(
          label: Text(time),
          selected: isSelected,
          onSelected: (bool selected) {
            onTimeSelected(time);
          },
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFF567DF4), // Azul seleccionado
          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
          padding: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }).toList(),
    );
  }
}