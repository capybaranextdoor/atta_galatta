import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  String _formatDate(DateTime date) {
    return DateFormat('d MMMM').format(date);
  }

  String _formatTime(String time) {
    final DateTime parsedTime = DateTime.parse('1970-01-01T$time');
    return DateFormat('h:mm a').format(parsedTime);
  } 

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        children: [
          // Event Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
              image: DecorationImage(
                image: NetworkImage(event.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Event Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Color(0xFF9C4F2E),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    event.subTitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${_formatDate(event.eventDay)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Color(0xFF9C4F2E)
                    ),
                  ),
                  Text(
                    '${_formatTime(event.startTime)} - ${_formatTime(event.endTime)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Color(0xFF9C4F2E)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
