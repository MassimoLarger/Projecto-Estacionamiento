import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reserva de Horarios',
      home: SchedulePage(),
    );
  }
}

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime selectedDate = DateTime.now();
  String selectedTimeSlot = '';
  List<String> bookedSlots = ['08:45', '11:00', '16:15', '21:30']; // Horarios reservados

  void _selectDate(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2025, 6, 7), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      setState(() {
        selectedDate = date;
      });
    }, currentTime: DateTime.now(), locale: LocaleType.es);
  }

  Widget timeSlotButton(String time) {
    bool isBooked = bookedSlots.contains(time);
    bool isSelected = selectedTimeSlot == time;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: FlatButton(
          onPressed: isBooked ? null : () {
            setState(() {
              selectedTimeSlot = time;
            });
          },
          color: isBooked ? Colors.red : isSelected ? Colors.purple : Colors.blue,
          child: Text(time,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendar Reserva'),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("Fecha: ${selectedDate.toLocal()}".split(' ')[0]),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () => _selectDate(context),
          ),
          Divider(),
          Text('Horarios'),
          Wrap(
            children: <String>['08:00', '08:45', '09:30', '10:15', '11:00', '11:45', '12:30']
                .map((time) => timeSlotButton(time)).toList(),
          ),
          Wrap(
            children: <String>['13:15', '14:00', '14:45', '15:30', '16:15', '17:00', '17:45', '18:30']
                .map((time) => timeSlotButton(time)).toList(),
          ),
          Wrap(
            children: <String>['19:15', '20:00', '20:45', '21:30', '22:15', '23:00', '23:45']
                .map((time) => timeSlotButton(time)).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: selectedTimeSlot.isNotEmpty ? () {
                // Aquí lógica para reservar
                print('Reservado $selectedTimeSlot el día $selectedDate');
              } : null,
              color: Colors.blue,
              child: Text('Reservar', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
