<<<<<<<< HEAD:lib/model/event.dart
import 'package:html/parser.dart' show parse;
========
// models/event.dart
>>>>>>>> 0f0f97f39a2a077c6880ff175be894422ff562b2:lib/model/model.dart

class Author {
  final String name;

  Author({required this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['AuthorName'],
    );
  }
}

class Event {
  final String id;
  final String title;
  final String subTitle;
  final List<Author> authors;
  final String imageUrl;
  final DateTime eventDay;
  final String startTime;
  final String endTime;
  final String description;

  Event({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.authors,
    required this.imageUrl,
    required this.eventDay,
    required this.startTime,
    required this.endTime,
    required this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    var authorsFromJson = json['Author_HostName'] as List;
    List<Author> authorList = authorsFromJson.map((author) => Author.fromJson(author)).toList();

    // Parse the HTML description to plain text
    String htmlDescription = json['EventContentDescription'];
    String plainTextDescription = parseHtmlToPlainText(htmlDescription);

    return Event(
      id: json['EventID'],
      title: json['EventTitle'],
      subTitle: json['EventSubTitle'],
      authors: authorList,
<<<<<<<< HEAD:lib/model/event.dart
      imageUrl: fullImageUrl,
      eventDay: DateTime.parse(json['EventDay']),
      startTime: json['EventStartTime'],
      endTime: json['EventEndTime'],
      description: plainTextDescription,
      registrationLink: json['RegsiterLink1'],
========
      imageUrl: 'https://attagalatta.com/images/${json['EventImage']}',
      eventDay: DateTime.parse(json['EventDay']),
      startTime: json['EventStartTime'],
      endTime: json['EventEndTime'],
      description: json['EventContentDescription'],
>>>>>>>> 0f0f97f39a2a077c6880ff175be894422ff562b2:lib/model/model.dart
    );
  }

  get eventId => null;

  get date => null;

  static String parseHtmlToPlainText(String html) {
    final document = parse(html);
    return parse(document.body!.text).documentElement!.text;
  }

  DateTime get startTimeAsDateTime => DateTime.parse(startTime);

  DateTime get endTimeAsDateTime => DateTime.parse(endTime);
}
