import 'package:flutter/material.dart';
import 'package:itrm_screen/globals.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
        child: BackButton(
          color: Colors.black,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 55),
            const Center(
              child: Text(
                "Notifications",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20), // Added space below the centered text
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length, // Example: Assuming there are 10 notifications
                itemBuilder: (context, index) {
                  List<Notif> nots=notifications.toList();
                  return ListTile(
                    // title: Text('Notification ${index + 1}'),
                    title: Text(nots[index].text),
                    subtitle: Text(getTime(nots[index].time),style: TextStyle(color: Colors.grey),),
                    leading: const CircleAvatar(
                      child: Icon(Icons.notifications),
                    ),
                    onTap: () {
                      // Handle tapping on the notification (if needed)
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
