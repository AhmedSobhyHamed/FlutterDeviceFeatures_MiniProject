import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            Center(child: Text('Profile')),
            Image.asset('assets/images/images.jpg', width: 100, height: 100),
            Center(child: Text('Name: John Doe')),
            Center(child: Text('Email: john.doe@example.com')),
            Center(child: Text('Phone: +1234567890')),
            Center(child: Text('Address: 123 Main St, Anytown, USA')),
            Center(child: Text('City: Anytown')),
            Center(child: Text('State: CA')),
            Center(child: Text('Zip: 12345')),
          ],
        ),
      ),
    ); 
  }
}