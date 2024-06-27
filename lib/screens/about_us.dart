import 'package:flutter/material.dart';

void main() {
  runApp(const AboutUsApp());
}

class AboutUsApp extends StatelessWidget {
  const AboutUsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Us',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AboutUsPage(),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ABOUT US',
          style: TextStyle(
            color: Color(0xFF242E3B),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Image.asset('assets/backarrow.png'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/lib3.png',
              height: 200, // Adjust height as needed
              width: MediaQuery.of(context).size.width, // Full width of the screen
              fit: BoxFit.cover, // Maintain aspect ratio and cover full width
            ),
            const SizedBox(height: 16),
            Text(
              'Atta Galatta is an independent Indian language bookstore and events space located in Indiranagar, Bengaluru. We offer a curated collection of books and host a wide range of community-centric events.',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Address:\n178, 5th Main Road,\n1st Stage, Indiranagar,\nBengaluru - 560038,\nKarnataka\n\nPhone: +91 96325 10126\nPhone: +91 80 44323614',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
