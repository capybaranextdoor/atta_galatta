import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const AboutUsPage());
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Us',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                'assets/lib3.png',
              ),
              SizedBox(height: 16),
              Text(
                'Atta Galatta is an independent Indian language bookstore and events space located in Indiranagar, Bengaluru. We offer a curated collection of books and host a wide range of community-centric events.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Address:\n178, 5th Main Road,\n1st Stage, Indiranagar,\nBengaluru - 560038,\nKarnataka\n\nPhone: +91 96325 10126\nPhone: +91 80 44323614',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
