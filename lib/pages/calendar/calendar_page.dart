import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  final List<DateTime> _occupiedDays = [
    DateTime.utc(2025, 4, 17),
    DateTime.utc(2025, 4, 25),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  bool _isDayOccupied(DateTime day) {
    for (var occupiedDay in _occupiedDays) {
      if (day.year == occupiedDay.year &&
          day.month == occupiedDay.month &&
          day.day == occupiedDay.day) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Text(
                'Calendar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            TableCalendar(
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              calendarStyle: CalendarStyle(
                markerDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              eventLoader: (day) {
                return _isDayOccupied(day) ? ['Occupied'] : [];
              },
              calendarBuilders: CalendarBuilders(
                todayBuilder: (context, day, focusedDay) {
                  return Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: _isDayOccupied(day) ? Colors.red : Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
