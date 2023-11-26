import 'package:flutter/material.dart';
import 'package:fitnessapp/edit_information.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Map<String, bool> _subSettings = {
    'Personal Information': true,
    'Fitness Goals': true,
    'Fitness Level': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.9),
        title: const Text('Profile Settings',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: _buildSubSettings(),
      ),
    );
  }

  List<Widget> _buildSubSettings() {
    return _subSettings.entries.map<Widget>((entry) {
      return Column(
        children: [
          ListTile(
            title: Text(
              entry.key,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              if (entry.key == 'Personal Information') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditInformation(FirebaseAuth
                          .instance.currentUser!)), // Change this line
                );
              }
            },
            trailing: _subSettings[entry.key]!
                ? const Icon(Icons.expand_less)
                : const Icon(Icons.expand_more),
          ),
          const Divider(),
        ],
      );
    }).toList();
  }
}
