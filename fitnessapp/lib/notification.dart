import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.9),
        title: Text('Notifications'),
      ),
      body: NotificationList(),
    );
  }
}

class NotificationItem {
  final DateTime date;
  final String title;

  NotificationItem(this.date, this.title);
}

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List<NotificationItem> notifications = [
    NotificationItem(DateTime(2023, 11, 22), 'Free FE Energy Drink'),
    NotificationItem(DateTime(2023, 11, 22), 'We Are Giving Out Free Pizza'),
    NotificationItem(
        DateTime(2023, 11, 22), 'FE Invites You To A Team Building Activity'),
    NotificationItem(
        DateTime(2023, 11, 22), 'Upgrade Now For A Premium FE Account'),
    NotificationItem(
        DateTime(2023, 11, 22), 'Good Job Finishing All The Exercises'),
  ];

  @override
  void initState() {
    super.initState();
    notifications.sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        NotificationItem notification = notifications[index];
        return Card(
          child: ListTile(
            // Add your icon or image here if needed
            title: Text(notification.title),
            subtitle: Text(_formatDate(notification.date)), // Format the date
          ),
        );
      },
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.month}-${dateTime.day}-${dateTime.year}';
  }
}
