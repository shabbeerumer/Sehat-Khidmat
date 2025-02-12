import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(16),
      color: Color(0xFF002147), // Dark blue background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo and Description
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/logo.png'), // Your logo path
                radius: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Sehat Khidmat offers easy access to medical appointments, medicines, diagnostic tests, and health products, making healthcare accessible and convenient for everyone.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Quick Links Section
          Text(
            'Quick Links',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              footerLink('About Us'),
              footerLink('Contact Us'),
              footerLink('FAQs'),
              footerLink('Book An Appointment'),
              footerLink('Order Medicine'),
            ],
          ),
          SizedBox(height: 20),

          // Contact Us Section
          Text(
            'Contact Us',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          contactRow(Icons.email, 'support@sehatkhidmat.com'),
          contactRow(Icons.phone, '+92 332 5567804'),
          SizedBox(height: 10),

          // Social Media Icons
          Row(
            children: [
              socialIcon(FontAwesomeIcons.facebook),
              socialIcon(FontAwesomeIcons.twitter),
              socialIcon(FontAwesomeIcons.linkedin),
              socialIcon(FontAwesomeIcons.instagram),
            ],
          ),
          SizedBox(height: 20),

          // Newsletter Subscription
          Text(
            'Let\'s Stay In Touch',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Subscribe for newsletter',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter Email',
              hintStyle: TextStyle(color: Colors.black54),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: Icon(Icons.send, color: Colors.green),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            ),
          ),
          SizedBox(height: 20),

          // Copyright Section
          Center(
            child: Text(
              'Copyright © 2024 Sehat Khidmat. Developed by:',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Footer Links
  Widget footerLink(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Text(
        '• $text',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  // Contact Row
  Widget contactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        SizedBox(width: 8),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }

  // Social Media Icons
  Widget socialIcon(IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}
