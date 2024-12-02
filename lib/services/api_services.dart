import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../model/event.dart';

class ApiService {
  final String baseUrl = 'https://attagalatta.com/api/v1';

Future<List<Event>> fetchEventsForNextWeek() async {
  DateTime now = DateTime.now();
  DateTime endDate = now.add(Duration(days: 7));
  String formattedStartDate = DateFormat('yyyy-MM-dd').format(now);
  String formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate);

  final url = Uri.parse('$baseUrl/getallevents.php').replace(queryParameters: {
    'StartDate': formattedStartDate,
    'EndDate': formattedEndDate,
  });
  print('Fetching events with URL: $url');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        List jsonResponse = json.decode(response.body);
        print('Response received: $jsonResponse');
        List<Event> events = jsonResponse.map((event) => Event.fromJson(event)).toList();
        events.sort((a, b) => a.eventDay.compareTo(b.eventDay));  // Sort by date
        return events.take(10).toList();  // Limit to 4 events
      } catch (e) {
        print('Error parsing response: $e');
        throw Exception('Failed to parse events');
      }
    } else {
      print('Failed to load events. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load events');
    }
  } catch (e) {
    print('Error during API call: $e');
    throw Exception('Failed to load events');
  }
}



Future<List<Event>> fetchEvents({required DateTime date}) async {
  final startDate = DateTime(date.year, date.month, date.day);
  final endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);
  final url = Uri.parse('$baseUrl/getallevents.php').replace(queryParameters: {
    'StartDate': startDate.toIso8601String(),
    'EndDate': endDate.toIso8601String(),
  });

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body) as List<dynamic>;
      List<Event> events = jsonResponse.map((dynamic event) => Event.fromJson(event as Map<String, dynamic>)).toList();
      
      // Sort events by start time in chronological order
      events.sort((a, b) => a.startTime.compareTo(b.startTime));

      return events;
    } else {
      throw Exception('Failed to load events: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Failed to load events: $e');
  }
}

  Future<Event> fetchEventDetailsById(String eventId) async {
    final response = await http.get(Uri.parse('$baseUrl/geteventfulldetails.php?EventID=$eventId'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        return Event.fromJson(jsonResponse[0] as Map<String, dynamic>);
      } else {
        throw Exception('No event details found');
      }
    } else {
      throw Exception('Failed to load event details');
    }
  }

  Future<Event> fetchEventDetailsByTitle(String eventTitle) async {
    final response = await http.get(Uri.parse('$baseUrl/geteventtitlebasedetails.php?EventTitle=${Uri.encodeComponent(eventTitle)}'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse is List && jsonResponse.isNotEmpty) {
        return Event.fromJson(jsonResponse[0] as Map<String, dynamic>);
      } else {
        throw Exception('No event details found');
      }
    } else {
      throw Exception('Failed to load event details');
    }
  }
 
}
