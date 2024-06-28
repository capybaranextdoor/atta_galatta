import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/event.dart';

class ApiService {
  final String baseUrl = 'https://attagalatta.com/api/v1';



  Future<List<Event>> fetchAllEvents() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/getallevents.php'));

      // Log the status code and response body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => Event.fromJson(item)).toList();
      } else {
        print('Failed to load events: ${response.statusCode} ${response.reasonPhrase}');
        throw Exception('Failed to load events: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load events: $e');
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
        return jsonResponse.map((dynamic event) => Event.fromJson(event as Map<String, dynamic>)).toList();
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
