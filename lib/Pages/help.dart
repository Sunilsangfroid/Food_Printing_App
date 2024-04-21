import 'package:flutter/material.dart';

class HelpFAQPage extends StatelessWidget {
  const HelpFAQPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & FAQ'),
        backgroundColor: Colors.transparent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How to Use the App:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '1. Sign up for an account to access all features of the app.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '2. Share your details like medical conditions, height, and weight in your account settings for personalized recommendations.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '3. Select the food you want to print from the available options.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '4. Set the sugar/spicy level and specify the number of calories you want in the food.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '5. Add the selected items to your cart for checkout.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '6. Connect to a nearby food printer to initiate the printing process.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '7. Once the food is printed, enjoy your meal!',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '8. Don\'t forget to leave a review for the food you tried to help others make informed decisions.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Information:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'For assistance or inquiries, please contact Prathmesh Chourasiya at:',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Phone: +91 8982986521',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
