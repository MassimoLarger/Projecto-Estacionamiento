import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'usuario.dart';
import 'espacios_estacionamiento.dart';

class BookingScreen extends StatefulWidget {
  final String userId;

  const BookingScreen({Key? key, required this.userId}) : super(key: key);

  @override
  BookingScreenState createState() => BookingScreenState();
}

class BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedPeriod; // Mañana, Tarde, Noche
  TimeOfDay? timeFrom;
  TimeOfDay? timeTo;

  final Map<String, Color> periodColors = {
    'Mañana': const Color(0xFFF3F8FF),
    'Tarde': const Color(0xFFF3F8FF),
    'Noche': const Color(0xFFF3F8FF),
  };

  final Map<String, List<String>> timeSlots = {
    'Mañana': List.generate(36, (index) {
      int hours = (index * 10 / 60 + 6).toInt();
      int minutes = (index * 10 % 60);
      if (hours == 24) hours = 0;
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    }),
    'Tarde': List.generate(48, (index) {
      int hours = (index * 10 / 60 + 12).toInt();
      int minutes = (index * 10 % 60);
      if (hours == 24) hours = 0;
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    }),
    'Noche': List.generate(25, (index) {
      int hours = (index * 10 / 60 + 20).toInt();
      int minutes = (index * 10 % 60);
      if (hours == 24) hours = 0;
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    }),
  };

  final Map<String, Color> selectedPeriodColors = {
    'Mañana': const Color(0xFFC6D4FF),
    'Tarde': const Color(0xFFC6D4FF),
    'Noche': const Color(0xFFC6D4FF),
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
    final times = timeSlots[selectedPeriod] ?? [];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        return Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: width * 0.01,
                width: width * 0.1,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
              ),
              SizedBox(height: width * 0.05),
              Text(
                isStartTime ? "Seleccione hora de inicio" : "Seleccione hora de fin",
                style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: width * 0.05),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                    crossAxisSpacing: width * 0.02,
                    mainAxisSpacing: width * 0.02,
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
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected ? const Color(0xFFC6D4FF) : const Color(0xFFF3F8FF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.02)),
                        padding: EdgeInsets.symmetric(vertical: width * 0.03),
                      ),
                      child: Text(
                        times[index],
                        style: TextStyle(color: Colors.black, fontSize: width * 0.035),
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
    double width = MediaQuery.of(context).size.width;

    bool canReserve = selectedDate != null && selectedPeriod != null && timeFrom != null && timeTo != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return CustomUserDialog(userId: widget.userId);
                },
              );
            },
          ),
        ],
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(width * 0.04),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: width * 0.0125),
            child: Text(
              'Agendar Reserva',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: width * 0.05),
            child: Text(
              'Selecciona la fecha y hora',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: width * 0.045,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: width * 0.03, horizontal: width * 0.04),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F8FF),
                borderRadius: BorderRadius.circular(width * 0.03),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd/MMM/yyyy').format(selectedDate),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.04,
                    ),
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: const Color(0xFF567DF4),
                    size: width * 0.06,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: width * 0.05),
          Text(
            'Horario',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width * 0.045,
            ),
          ),
          Wrap(
            spacing: width * 0.13,
            children: ['Mañana', 'Tarde', 'Noche'].map((period) {
              return ChoiceChip(
                label: Text(period),
                selected: selectedPeriod == period,
                onSelected: (selected) {
                  setState(() => selectedPeriod = period);
                },
                backgroundColor: selectedPeriod == period ? selectedPeriodColors[period] : periodColors[period],
                selectedColor: selectedPeriodColors[period],
                labelStyle: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: width * 0.035,
                ),
              );
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.only(top: width * 0.025, bottom: width * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Desde:',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => _showTimeSelection(context, isStartTime: true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3F8FF),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: width * 0.03),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.02),
                        side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      timeFrom?.format(context) ?? 'Elige hora',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.035,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: width * 0.025, bottom: width * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Hasta:',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => _showTimeSelection(context, isStartTime: false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3F8FF),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: width * 0.03),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width * 0.02),
                        side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      timeTo?.format(context) ?? 'Elige hora',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.035,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: width * 0.63),
          ElevatedButton(
            onPressed: canReserve
                ? () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => EspacioEstacionamientoWidget(userId: widget.userId)));
                }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: canReserve ? const Color(0xFF567DF4) : Colors.grey,
              foregroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: width * 0.04,
              ),
              padding: EdgeInsets.symmetric(vertical: width * 0.05),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.06)),
            ),
            child: const Text(
              'Reservar',
              style: TextStyle(
                fontFamily: 'Lato',
                color: Color.fromARGB(255, 255, 255, 255),
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