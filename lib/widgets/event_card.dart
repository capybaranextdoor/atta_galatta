// widgets/event_card.dart

import 'package:flutter/material.dart';
import '../model/model.dart';
import '../screens/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(eventId: event.id),
          ),
        );
      },
      child: Card(
        color: const Color(0xFF9C4F2E), // Set the card color to HEX: #9C4F2E
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              event.imageUrl,
              fit: BoxFit.cover,
              height: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Optional: Adjust text color for better contrast
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Organizer: ${event.authors.map((author) => author.name).join(", ")}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white, // Optional: Adjust text color for better contrast
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Date & Time: ${event.eventDay.day}/${event.eventDay.month}/${event.eventDay.year}, ${event.startTime} - ${event.endTime}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white, // Optional: Adjust text color for better contrast
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
