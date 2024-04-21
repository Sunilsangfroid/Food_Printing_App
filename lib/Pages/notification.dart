import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        // backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: 10, // Example: Assuming there are 10 notifications
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Notification ${index + 1}'),
            subtitle: const Text('This is a sample notification.'),
            leading: const CircleAvatar(
              child: Icon(Icons.notifications),
            ),
            onTap: () {
              // Handle tapping on the notification (if needed)
            },
          );
        },
      ),
    );
  }
}
