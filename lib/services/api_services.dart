// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '/model/model.dart';

class ApiService {
  final String baseUrl = 'https://attagalatta.com/api/v1';

  Future<List<Event>> fetchEvents({required DateTime startDate, required DateTime endDate}) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/getallevents.php?StartDate=${startDate.toIso8601String()}&EndDate=${endDate.toIso8601String()}'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<Event> fetchEventDetailsById(String eventId) async {
    final response = await http.get(Uri.parse('$baseUrl/geteventfulldetails.php?EventID=$eventId'));

    if (response.statusCode == 200) {
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load event details');
    }
  }

  Future<Event> fetchEventDetailsByTitle(String eventTitle) async {
    final response = await http.get(Uri.parse('$baseUrl/geteventtitlebasedetails.php?EventTitle=${Uri.encodeComponent(eventTitle)}'));

    if (response.statusCode == 200) {
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load event details');
    }
  }
}
