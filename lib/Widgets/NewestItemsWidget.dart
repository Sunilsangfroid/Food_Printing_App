import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../foodclass.dart';



class NewestItemsWidget extends StatefulWidget {
  const NewestItemsWidget({super.key});

  @override
  State<NewestItemsWidget> createState() => _NewestItemsWidgetState();
}

class _NewestItemsWidgetState extends State<NewestItemsWidget> {
  @override
  void favouriteItem(id){
    if (favourites.contains(id))favourites.remove(id);
    else favourites.add(id);
    setState((){});
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            // Single Item
            for (int id in newest.keys)
            GestureDetector(
              onTap: (){Navigator.pushNamed(context, "/item",arguments: id).then((value) => setState((){}));},
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                newest[id]!.imagePath,
                                fit: BoxFit
                                    .cover, // Fit the image within the container
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  newest[id]!.name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  newest[id]!.shortDesc,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemSize: 18,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.blue,
                                      ),
                                      onRatingUpdate: (index) {},
                                    ),
                                    Text(
                                      "\$10",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: (){favouriteItem(id);},
                                  icon: Icon(
                                    favourites.contains(id)?Icons.favorite:Icons.favorite_border,
                                    color: Colors.blue,
                                    size: 26,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cart[id] = 0;
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.cart,
                                    color: Colors.blue,
                                    size: 26,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            )
            // Other items go here...
          ],
        ),
      ),
    );
  }
}