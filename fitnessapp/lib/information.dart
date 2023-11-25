import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homepage.dart'; // Import your Home screen

class Information extends StatefulWidget {
  final User user;

  Information(this.user);

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? selectedSex;
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  void saveInformation() async {
    try {
      await firestore.collection('user_information').doc(widget.user.uid).set({
        'age': ageController.text,
        'height': heightController.text,
        'weight': weightController.text,
        'sex': selectedSex,
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print(e);
      // Handle error while saving data
      // You can show an error message to the user here
    }
  }

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

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
                width: 150,
                height: 150,
                child: Image.asset(
                  'lib/assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24.0),
              const Text(
                'Forever Endeavor',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 24.0),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
              ),
              TextField(
                controller: heightController,
                decoration: InputDecoration(
                  labelText: 'Height(cm)',
                ),
              ),
              TextField(
                controller: weightController,
                decoration: InputDecoration(
                  labelText: 'Weight(kg)',
                ),
              ),
              const SizedBox(height: 16.0),
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
                items: <String>['', 'Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value.isEmpty ? null : value,
                    child: Text(value.isEmpty ? ' ' : value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: saveInformation,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 12.0,
                  ),
                  textStyle: const TextStyle(fontSize: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
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
