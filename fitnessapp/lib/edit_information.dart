import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditInformation extends StatefulWidget {
  final User user;

  const EditInformation(this.user, {super.key});

  @override
  _EditInformationState createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String? selectedSex; // Added for dropdown selection

  @override
  void initState() {
    super.initState();
    // Fetch user information and populate the text fields
    fetchUserInfo();
  }

  void fetchUserInfo() async {
    try {
      DocumentSnapshot doc = await firestore
          .collection('user_information')
          .doc(widget.user.uid)
          .get();

      if (doc.exists) {
        setState(() {
          nameController.text = doc['name'];
          ageController.text = doc['age'];
          heightController.text = doc['height'];
          weightController.text = doc['weight'];
          selectedSex = doc['sex'] ?? ''; // Set selected sex if available
        });
      }
    } catch (e) {
      print(e);
      // Handle error while fetching data
    }
  }

  void updateInformation() async {
    try {
      await firestore
          .collection('user_information')
          .doc(widget.user.uid)
          .update({
        'name': nameController.text,
        'age': ageController.text,
        'height': heightController.text,
        'weight': weightController.text,
        'sex': selectedSex, // Include selectedSex information
      });

      // Optional: Show a success message or navigate back to the previous screen
    } catch (e) {
      print(e);
      // Handle error updating information
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
              ),
              TextField(
                controller: heightController,
                decoration: const InputDecoration(
                  labelText: 'Height(cm)',
                ),
              ),
              TextField(
                controller: weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight(kg)',
                ),
              ),
              DropdownButtonFormField<String>(
                value: selectedSex,
                onChanged: (newValue) {
                  setState(() {
                    selectedSex = newValue;
                  });
                },
                items: ['Male', 'Female']
                    .map((sex) => DropdownMenuItem<String>(
                          value: sex,
                          child: Text(sex),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'Sex',
                ),
              ),
              ElevatedButton(
                onPressed: updateInformation,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
