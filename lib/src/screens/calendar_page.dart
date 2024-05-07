import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar Example'),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'ru_RU',
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: testEvents.length,
              itemBuilder: (context, index) {
                final event = testEvents[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      // Иконка типа занятия (можно заменить на иконку в соответствии с типом)
                      Icon(Icons.event, color: Colors.black),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Время начала и окончания (можно заменить на время из события)
                          Text('Время: 10:00 - 11:00', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          // Заголовок события
                          Text(event.title),
                          SizedBox(height: 4),
                          // Описание события
                          Text(event.description),
                        ],
                      ),
                      Spacer(),
                      // Отображение статуса свободно/занято (можно заменить на иконку или текст в соответствии со статусом)
                      Icon(Icons.home),
                    ],
                  ),
                );
              },
            ),

          ),
        ],
      ),
    );

  }
}

class Event {
  final String title;
  final String description;


  Event(this.title, this.description);
}

// Пример тестовых данных: список событий для нескольких дат
final List<Event> testEvents = [
  Event('Физика', 'Описание важного события 1'),
  Event('Математика', 'Описание важного события 2'),
  Event('Важное событие 3', 'Описание важного события 3'),
];