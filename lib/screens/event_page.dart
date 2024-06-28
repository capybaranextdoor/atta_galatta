import 'package:flutter/material.dart';
import '../model/event.dart';
import '../services/api_services.dart';
import '../widgets/event_card.dart';
import 'event_details.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final ApiService apiService = ApiService();
  late Future<List<Event>> events;
  DateTime selectedDate = DateTime.now(); // Use present day

  @override
  void initState() {
    super.initState();
    // Fetch events for the present day
    events = apiService.fetchEvents(date: selectedDate);
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF9C4F2E), // Header background color
              onPrimary: Colors.white, // Header text color
              surface: Colors.white, // Selected date background color
              onSurface: Colors.black, // Selected date text color
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the date picker dialog
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Fetch events for the updated selectedDate
        events = apiService.fetchEvents(date: selectedDate);
      });
    }
  }

  Future<void> _refreshEvents() async {
    setState(() {
      // Reset the events Future to trigger refetching of events
      events = apiService.fetchEvents(date: selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9C4F2E),
        title: const Text(
          'Events',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _selectDate,
            color:Colors.white
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshEvents,
        child: FutureBuilder<List<Event>>(
          future: events,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('No Network Found'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No Events Today:(',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EventDetailPage(eventId: snapshot.data![index].id),
                        ),
                      );
                    },
                    child: EventCard(event: snapshot.data![index]),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
