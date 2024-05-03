// ignore_for_file: override_on_non_overriding_member, avoid_init_to_null, prefer_if_null_operators, avoid_print, annotate_overrides

import 'package:flutter/material.dart';
import 'package:itrm_screen/globals.dart';

class ReviewScreen extends StatefulWidget {
  final int itemId; // Item ID to fetch related reviews

  const ReviewScreen({super.key, required this.itemId});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  List<Review?> reviews = [];
  Review? userReview=null;

  void fetchRatings() async{
    await db.collection("ratings").where("fid", isEqualTo: widget.itemId).get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        var data=doc.data();
        print(data);
        reviews.add(Review(
            name: data['name']!=null?data['name']:'Anonyomous',
            profileImage: 'assets/images/avatar.png',
            rating: data['rating'],
            reviewText: data['review']!=null?data['review']:'',
            itemId: widget.itemId, uid: data['uid']
        ));
      }
      print('testing');
      try {
        userReview = reviews.firstWhere((element) => element!.uid ==
            firebaseAuth.currentUser!.uid,orElse: ()=>null);
      }catch (e){
        userReview=null;
      }
      reviews.remove(userReview);
      setState(() {});
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRatings();
  }
  Widget build(BuildContext context) {
    // List<Review> reviews = [
    //   Review(
    //     name: 'John Doe',
    //     profileImage: 'assets/images/avatar.png',
    //     rating: 4.5,
    //     reviewText:
    //         'This cake is absolutely delicious! It exceeded my expectations.',
    //     itemId: itemId,
    //   ),
    //   Review(
    //     name: 'Jane Smith',
    //     profileImage: 'assets/images/avatar.png',
    //     rating: 5.0,
    //     reviewText: 'I love this cake! Highly recommended.',
    //     itemId: itemId,
    //   ),
    //   Review(
    //     name: 'Alex Johnson',
    //     profileImage: 'assets/images/avatar.png',
    //     rating: 4.0,
    //     reviewText: 'Good cake, but could be better.',
    //     itemId: itemId,
    //   ),
    //   Review(
    //     name: 'Emily Brown',
    //     profileImage: 'assets/images/avatar.png',
    //     rating: 3,
    //     reviewText: 'Decent cake, but not my favorite flavor.',
    //     itemId: itemId,
    //   ),
    //   // Add more reviews as needed
    // ];


    // Filter reviews based on the item ID (for demonstration)
    // List<Review> filteredReviews =
    //     reviews.where((review) => review.itemId == widget.itemId).toList();

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child:  const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 31),
            const Center(
              child: Text(
                "Item Reviews",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 40),
            if (userReview!=null)
            buildReviewCard(userReview!),
            const Divider(),
            if (reviews.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return buildReviewCard(reviews[index]!);
                },
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReviewCard(Review review) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(review.profileImage),
                  radius: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  review.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                if (review.uid==firebaseAuth.currentUser!.uid)
                  const Text(' (you)', style: TextStyle(color: Colors.grey),)
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 24),
                Text(
                  review.rating.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review.reviewText,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String name;
  final String profileImage;
  final double rating;
  final String reviewText;
  final int itemId;
  final String uid;

  Review({
    required this.name,
    required this.profileImage,
    required this.rating,
    required this.reviewText,
    required this.itemId,
    required this.uid,
  });
}
