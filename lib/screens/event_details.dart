import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../model/event.dart';

import '../services/api_services.dart';
import 'package:intl/intl.dart';


class EventDetailPage extends StatelessWidget {
  final String eventId;

  EventDetailPage({required this.eventId});
  
  String _formatDate(DateTime date) {
    return DateFormat('d MMMM').format(date);
  }

  String _formatTime(String time) {
    final DateTime parsedTime = DateTime.parse('1970-01-01T$time');
    return DateFormat('h:mm a').format(parsedTime);
  }


  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF9C4F2E),
        title: Text('Event Details', style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white
          ),),
          iconTheme: const IconThemeData(color: Colors.white),
       
      ),
      body: FutureBuilder<Event>(
        future: apiService.fetchEventDetailsById(eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No event details found'));
          } else {
            final event = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(event.imageUrl, fit: BoxFit.cover),
                    ),
                    SizedBox(height: 20),
                    Text(
                      event.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                     
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF9C4F2E),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      event.subTitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 20),
                    ...event.authors.map((author) => Text(author.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF9C4F2E)))).toList(),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9C4F2E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_formatDate(event.eventDay)}',
                           
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${_formatTime(event.startTime)} - ${_formatTime(event.endTime)}',
                            
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
  
                    Text(
                      event.description,
          
                    ),
                    SizedBox(height: 20),
                    if (event.registrationLink != null && event.registrationLink!.isNotEmpty)
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final url = event.registrationLink!;
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF9C4F2E),
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          child: Text('Register'),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
