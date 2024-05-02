import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../foodclass.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void favouriteItem(int id) {
    if (favourites.contains(id)) {
      favourites.remove(id);
    } else {
      favourites.add(id);
    }
    setState(() {});
  }
  String query="";


  @override
  Widget build(BuildContext context) {
    query = query=="" ? ModalRoute.of(context)!.settings.arguments as String : query;
    print("query = $query");
    List<int> results=availFood.keys
        .where((id) => availFood[id]!.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(
              "Searched For: $query",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    // Single Item
                    for (int id in results)
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/item", arguments: id)
                              .then((value) => setState(() {}));
                        },
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
                                      child: AspectRatio(
                                        aspectRatio: 0.65,
                                        child: Image.asset(
                                          availFood[id]!.imagePath,
                                          fit: BoxFit.cover,
                                        ),
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
                                          availFood[id]!.name,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          availFood[id]!.shortDesc,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 53,
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
                                                color: Colors.yellow,
                                              ),
                                              onRatingUpdate: (index) {},
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
                                          onPressed: () {
                                            favouriteItem(id);
                                          },
                                          icon: Icon(
                                            favourites.contains(id)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: favourites.contains(id)
                                                ? Colors.red
                                                : Colors.blue,
                                            size: 26,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 65,
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
                      ),
                    // Other items go here...
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
