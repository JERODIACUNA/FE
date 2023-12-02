import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class EditInformation extends StatefulWidget {
  final User user;

  const EditInformation(this.user, {Key? key}) : super(key: key);

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
  bool userDeleted = false; // Track user deletion

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

  void deleteUser(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                try {
                  // Delete user information document
                  await firestore
                      .collection('user_information')
                      .doc(widget.user.uid)
                      .delete();

                  // Delete the user's Firebase authentication account
                  await widget.user.delete();

                  // Navigate back to loginscreen after successful deletion
                  setState(() {
                    userDeleted = true; // Update the user deletion status
                  });
                } catch (e) {
                  print(e);
                  // Handle error while deleting user or user information
                }
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
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
        backgroundColor: Colors.blue.withOpacity(0.9),
        title: const Text('Edit Information'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IgnorePointer(
                ignoring:
                    userDeleted, // Disable interaction when userDeleted is true
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
                    ElevatedButton(
                      onPressed: updateInformation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.withOpacity(.9),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        deleteUser(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.withOpacity(.9),
                      ),
                      child: const Text('Delete Account'),
                    ),
                    // Blur effect when userDeleted is true
                    if (userDeleted)
                      Container(
                        color: Colors.black.withOpacity(0.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Successfully deleted the account',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 70, 233, 255),
                                  ),
                                  child: const Text('Back to Login'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
