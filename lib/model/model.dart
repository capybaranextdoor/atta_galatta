// models/event.dart

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

    return Event(
      id: json['EventID'],
      title: json['EventTitle'],
      subTitle: json['EventSubTitle'],
      authors: authorList,
      imageUrl: 'https://attagalatta.com/images/${json['EventImage']}',
      eventDay: DateTime.parse(json['EventDay']),
      startTime: json['EventStartTime'],
      endTime: json['EventEndTime'],
      description: json['EventContentDescription'],
    );
  }
}
