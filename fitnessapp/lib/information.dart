import 'package:flutter/material.dart';
import 'homepage.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  String? selectedSex; // No longer a state variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
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
                  labelText: 'Age',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Height',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Weight',
                ),
              ),
              const SizedBox(
                  height: 16.0), // Adding space between Weight and Sex
              // Dropdown for selecting sex
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Sex',
                  border: OutlineInputBorder(),
                ),
                value: selectedSex,
                onChanged: (newValue) {
                  setState(() {
                    selectedSex = newValue;
                  });
                },
                items: <String>['', 'Male', 'Female'] // Added blank option
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.isEmpty ? ' ' : value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Text('Submit'),
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
