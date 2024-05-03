import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:itrm_screen/foodclass.dart';
import 'package:itrm_screen/globals.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double rating = 4.0;
  String review = '';

  @override
  Widget build(BuildContext context) {
    final fid = ModalRoute.of(context)?.settings.arguments as int?;

    if (fid == null) {
      // Handle if fid is null (for example, show an error message)
      return Scaffold(
        body: Center(
          child: Text(
            'Error: Food ID not provided',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      );
    }

    final foodImage = availFood[fid]?.imagePath ?? '';
    final foodName = availFood[fid]?.name ?? '';
    final categoryImage = availFood[fid]?.tags.first ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Feedback for $foodName',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(foodImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(categoryImage),
                              radius: 35,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            foodName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '45 Reviews',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Food Printed',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Please Rate Printing Service',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            alignment: Alignment.center,
                            child: RatingBar.builder(
                              initialRating: rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 40,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              onRatingUpdate: (newRating) {
                                setState(() {
                                  rating = newRating;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: const InputDecoration(
                              hintText: 'Write your review...',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                            onChanged: (value) {
                              setState(() {
                                review = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              addRating(fid, rating, review);
                              print('Rating: $rating, Review: $review');
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/home',
                                (route) => false,
                              );
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: FeedbackScreen(),
  ));
}
