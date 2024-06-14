import 'package:flutter/material.dart';

void main() {
  runApp(const AboutUsPage());
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Us',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ABOUT US',
          style: TextStyle(color: Color(0xFF242E3B),fontWeight: FontWeight.bold),),
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
              ),
              const SizedBox(height: 16),
              const Text(
                'Atta Galatta is an independent Indian language bookstore and events space located in Indiranagar, Bengaluru. We offer a curated collection of books and host a wide range of community-centric events.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')
                ,
              ),
              const SizedBox(height: 24),
              const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Address:\n178, 5th Main Road,\n1st Stage, Indiranagar,\nBengaluru - 560038,\nKarnataka\n\nPhone: +91 96325 10126\nPhone: +91 80 44323614',
                style: TextStyle(fontSize: 16,  fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
