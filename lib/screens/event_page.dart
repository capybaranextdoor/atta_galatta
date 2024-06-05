import 'package:flutter/material.dart';
import '../model/model.dart';
import '../services/api_services.dart';
import '../widgets/event_card.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final ApiService apiService = ApiService();
  late Future<List<Event>> events;
  DateTime startDate = DateTime(2024, 5, 1);
  DateTime endDate = DateTime(2024, 5, 31);

  @override
  void initState() {
    super.initState();
    events = apiService.fetchEvents(startDate: startDate, endDate: endDate);
  }



  void _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
    );
    if (picked != null && picked != DateTimeRange(start: startDate, end: endDate)) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
        events = apiService.fetchEvents(startDate: startDate, endDate: endDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: _selectDateRange,
          ),
        ],
      ),
      body: FutureBuilder<List<Event>>(
        future: events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No events found'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return EventCard(event: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
