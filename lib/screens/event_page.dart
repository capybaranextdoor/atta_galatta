import 'package:flutter/material.dart';
import '../model/model.dart';
import '../services/api_services.dart';
import '../widgets/event_card.dart';
import 'event_details.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final ApiService apiService = ApiService();
  late Future<List<Event>> events;
  DateTime selectedDate = DateTime(2024, 5, 1);

  @override
  void initState() {
    super.initState();
    // Call fetchEvents function with selectedDate
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
        // Call fetchEvents function with updated selectedDate
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _selectDate,
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xff242E3B),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF9C4F2E),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Text(
                  'ATTA GALATTA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: const Text(
                  'About Us',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/about-us');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.contact_mail,
                  color: Colors.white,
                ),
                title: const Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/contact-us');
                },
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        // Wrap your ListView.builder with RefreshIndicator
        onRefresh: _refreshEvents,
        child: FutureBuilder<List<Event>>(
          future: events,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('NO EVENTS FOUND'));
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
