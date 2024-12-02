import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  void _launchURL(String url) async {
    if (await launchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ContactCard(
              icon: FontAwesomeIcons.whatsapp,
              label: 'WhatsApp',
              contactInfo: '+91 9632510126',  // Replace with your phone number
              url: 'https://wa.me/919632510126',  // Replace with your phone number in the correct format
            ),
            ContactCard(
              icon: Icons.phone,
              label: 'Phone',
              contactInfo: '+0987654321',
              url: 'tel:+0987654321',
            ),
            ContactCard(
              icon: FontAwesomeIcons.instagram,
              label: 'Instagram',
              contactInfo: '@attagalatta',  // Replace with your Instagram username
              url: 'https://www.instagram.com/attagalatta/', 
            ),
            ContactCard(
              icon: Icons.email,
              label: 'Email',
              contactInfo: 'info@attagalatta.com',
              url: 'mailto:info@attagalatta.com',
            ),
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String contactInfo;
  final String url;

  const ContactCard({
    super.key,
    required this.icon,
    required this.label,
    required this.contactInfo,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          _launchURL(url);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: const Color(0xFF9C4F2E),
              ),
              const SizedBox(width: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    contactInfo,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
