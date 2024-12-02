import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 4),
                  child: Text(
                    "Calendar",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xff33404f),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Knewave',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(1950, 1, 1),
                lastDay: DateTime.utc(2050, 1, 1),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: onDaySelected,
                calendarFormat: _calendarFormat,
                onFormatChanged: onFormatChanged,
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, events) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xff33404f), 
                        shape: BoxShape.circle,
                      ),
                      width: 40,
                      height: 40,
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  todayBuilder: (context, date, events) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xff33404f).withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void onFormatChanged(format) {
    if (_calendarFormat != format) {
      setState(() {
        _calendarFormat = format;
      });
    }
  }
}
