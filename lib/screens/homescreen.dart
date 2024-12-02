import 'package:flutter/material.dart';
import '../model/event.dart';
import '../services/api_services.dart';
import '../widgets/event_card.dart';
import 'event_details.dart';
import '../model/event.dart';
import '../services/api_services.dart';
import '../widgets/event_card.dart';
import 'event_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Event>> events;

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Event>> events;

  @override
  void initState() {
    super.initState();
    events = apiService.fetchEventsForNextWeek();
    events = apiService.fetchEventsForNextWeek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9C4F2E),
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.event, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/events');
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
      body: FutureBuilder<List<Event>>(
        future: events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Failed to load events', style: TextStyle(fontWeight: FontWeight.bold)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Events Today'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailPage(eventId: event.id), // Ensure event.id is not null
                      ),
                    );
                  },
                  child: EventCard(event: event),
                );
              },
            );
          }
        },
      ),
    );
  }
}
