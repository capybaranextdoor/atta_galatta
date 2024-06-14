import 'package:flutter/material.dart';
import 'screens/about_us.dart';
import 'screens/contact_us.dart';

import 'screens/event_page.dart';
import 'screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atta Galatta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/events': (context) => const EventsPage(),
        '/about-us': (context) => const AboutUsPage(),
        '/contact-us': (context) => const ContactUsPage(),
      },
    );
  }
}
