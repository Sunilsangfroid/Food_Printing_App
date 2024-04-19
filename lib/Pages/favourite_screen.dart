import 'package:flutter/material.dart';
import '../foodclass.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FoodDeliveryScreen(),
    );
  }
}

class FoodDeliveryScreen extends StatefulWidget {
  @override
  _FoodDeliveryScreenState createState() => _FoodDeliveryScreenState();
}

class _FoodDeliveryScreenState extends State<FoodDeliveryScreen> {

  List<String> wishlistItems = [];

  void addToWishlist(String item) {
    setState(() {
      wishlistItems.add(item);
    });
  }

  void deleteFromCart(int id){
    setState(() {
      cart.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color defaultBlue =Theme.of(context).primaryColor;

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0,horizontal: 10.0),
        child: BackButton(
          color: Colors.black,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 31,),
            const Center(
              child: Text("Favourites",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ),
            const SizedBox(height: 40,),
            Expanded(
              child: ListView(
                children: [
                  // ...cart.keys.map((id) => Placeholder())
                  for (int id in favourites)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    availFood[id]!.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                )
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Expanded(child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                                Text(availFood[id]!.name,style: const TextStyle(fontSize: 19,fontWeight: FontWeight.w800),),
                                Container(height: 30,child: IconButton(onPressed: ()=>deleteFromCart(id), icon: const Icon(Icons.close),color: defaultBlue,iconSize: 20,))
                              ],),
                              Text(availFood[id]!.shortDesc,style: const TextStyle(color: Colors.grey),),
                            ],
                          ))
                        ],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Food Delivery App'),
  //     ),
  //     body: ListView.builder(
  //       itemCount: foodItems.length,
  //       itemBuilder: (context, index) {
  //         final foodItem = foodItems[index];
  //         final isInWishlist = wishlistItems.contains(foodItem);
  //         return ListTile(
  //           title: Text(foodItem),
  //           trailing: IconButton(
  //             icon: isInWishlist
  //                 ? Icon(Icons.favorite, color: Colors.red)
  //                 : Icon(Icons.favorite_border),
  //             onPressed: () {
  //               if (isInWishlist) {
  //                 setState(() {
  //                   wishlistItems.remove(foodItem);
  //                 });
  //               } else {
  //                 addToWishlist(foodItem);
  //               }
  //             },
  //           ),
  //         );
  //       },
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => WishlistScreen(wishlistItems)),
  //         );
  //       },
  //       child: Icon(Icons.favorite),
  //     ),
  //   );
  // }
}

class WishlistScreen extends StatelessWidget {
  final List<String> wishlistItems;

  WishlistScreen(this.wishlistItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(wishlistItems[index]),
          );
        },
      ),
    );
  }
}
