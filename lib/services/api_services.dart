import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/model.dart';

class ApiService {
  final String baseUrl = 'https://attagalatta.com/api/v1';

  Future<List<Event>> fetchEvents({required DateTime date}) async {
    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final response = await http.get(Uri.parse(
        '$baseUrl/getallevents.php?StartDate=${startDate.toIso8601String()}&EndDate=${endDate.toIso8601String()}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map((event) => Event.fromJson(event as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load events');
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

  Future<List<Event>> fetchUpcomingEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/getallevents.php'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body) as List;
      List<Event> events = jsonResponse.map((event) => Event.fromJson(event as Map<String, dynamic>)).toList();
      events.sort((a, b) => a.eventDay.compareTo(b.eventDay));
      return events.take(3).toList();
    } else {
      throw Exception('Failed to load upcoming events');
    }
  }
}
