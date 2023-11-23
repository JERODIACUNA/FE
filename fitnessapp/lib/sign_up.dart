import 'package:flutter/material.dart';
import 'information.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 150, // Adjust the width as needed
                height: 150, // Adjust the height as needed
                child: Image.asset(
                  'lib/assets/logo.png', // Replace with your image path
                  fit: BoxFit.contain, // Ensure the image fits within the box
                ),
              ),
              const SizedBox(
                  height: 0), // Add some space between image and text
              const Text(
                'Forever Endeavor',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Change color as needed
                  // You can apply custom fonts here using Google Fonts or local assets
                  // fontFamily: 'YourCustomFont',
                ),
              ),
              const SizedBox(height: 24.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Information()),
                  );
                },
                child: const Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Text color of the button
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0), // Padding around the text
                  textStyle:
                      const TextStyle(fontSize: 16.0), // Font size of the text
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15.0), // Makes the button corners rounded
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
