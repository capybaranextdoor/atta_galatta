import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/api_services.dart';
import '../model/event.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final ApiService apiService = ApiService();
  DateTime selectedDate = DateTime.now();
  Map<DateTime, List<Event>> eventsMap = {};
  Set<DateTime> eventDates = {};

  @override
  void initState() {
    super.initState();
    _fetchEvents(selectedDate);
  }

  Future<void> _fetchEvents(DateTime date) async {
    List<Event> fetchedEvents = await apiService.fetchEvents(date: date);
    setState(() {
      eventsMap = _groupEventsByDate(fetchedEvents);
      eventDates = eventsMap.keys.toSet();
    });
  }

  Map<DateTime, List<Event>> _groupEventsByDate(List<Event> events) {
    Map<DateTime, List<Event>> data = {};
    for (var event in events) {
      final eventDate = DateTime(
        event.eventDay.year,
        event.eventDay.month,
        event.eventDay.day,
      );
      if (data[eventDate] == null) {
        data[eventDate] = [];
      }
      data[eventDate]!.add(event);
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime(2020),
      lastDay: DateTime(2026),
      focusedDay: selectedDate,
      eventLoader: (day) {
        return eventsMap[day] ?? [];
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Positioned(
              right: 1,
              bottom: 1,
              child: _buildEventsMarker(date, events),
            );
          }
          return null;
        },
      ),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          selectedDate = selectedDay;
        });
      },
      selectedDayPredicate: (day) {
        return isSameDay(day, selectedDate);
      },
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
