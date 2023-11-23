import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, bool> _expandedSections = {
    'Profile Settings': true,
    'Account Settings': true,
    'Workout Settings': false,
    'Nutrition Settings': false,
    'Progress Tracking': false,
    'Community and Social Settings': false,
    'General Settings': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.9),
        title: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: _buildSettings(),
      ),
    );
  }

  List<Widget> _buildSettings() {
    List<Widget> settingsList = [];

    _expandedSections.forEach((title, isExpanded) {
      settingsList.add(ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          setState(() {
            _expandedSections[title] = !isExpanded;
          });
        },
        trailing:
            isExpanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
      ));

      settingsList.add(Divider());

      if (isExpanded) {
        settingsList.addAll(_getSubSettings(title));
        settingsList.add(Divider());
      }
    });

    return settingsList;
  }

  List<Widget> _getSubSettings(String section) {
    switch (section) {
      case 'Profile Settings':
        return [
          ListTile(
              title: Text('Personal Information',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Fitness Goals',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Fitness Level',
                  style: TextStyle(fontWeight: FontWeight.w500))),
        ];
      case 'Account Settings':
        return [
          ListTile(
              title: Text('Login & Security',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Notification Preferences',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Privacy Settings',
                  style: TextStyle(fontWeight: FontWeight.w500))),
        ];
      case 'Workout Settings':
        return [
          ListTile(
              title: Text('Workout Preferences',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Workout Difficulty',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Customization',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Music Integration',
                  style: TextStyle(fontWeight: FontWeight.w500))),
        ];
      case 'Nutrition Settings':
        return [
          ListTile(
              title: Text('Dietary Preferences',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Meal Reminders',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Calorie/Macro Goals',
                  style: TextStyle(fontWeight: FontWeight.w500))),
        ];
      case 'Progress Tracking':
        return [
          ListTile(
              title: Text('Measurement Units',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Progress Display',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Graphs/Charts',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Sync with Wearable Devices',
                  style: TextStyle(fontWeight: FontWeight.w500))),
        ];
      case 'Community and Social Settings':
        return [
          ListTile(
              title: Text('Friend Invites',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Social Sharing',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Community Interaction',
                  style: TextStyle(fontWeight: FontWeight.w500))),
        ];
      case 'General Settings':
        return [
          ListTile(
              title: Text('Language',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Theme/Interface Customization',
                  style: TextStyle(fontWeight: FontWeight.w500))),
          ListTile(
              title: Text('Data Sync and Backup',
                  style: TextStyle(fontWeight: FontWeight.w500))),
        ];

      default:
        return [];
    }
  }
}
