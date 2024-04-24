// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itrm_screen/globals.dart';
import 'dart:math';

class FoodItem {
  String name;
  String description;
  String shortDesc;
  double rating;
  int reviews;
  String imagePath;
  final int id;
  // final id = UniqueKey().hashCode;

  FoodItem({this.name="",this.description="",this.shortDesc="",this.rating=0.0,this.reviews=0,this.imagePath="",required this.id});
  factory FoodItem.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FoodItem(
      name: data?['name'],
      description: data?['description'],
      shortDesc: data?['shortDesc'],
      rating: Random().nextDouble()*5,
      reviews: Random().nextInt(5000),
      imagePath: data?['imagePath'],
      id: data?['id']
    );
  }
  Map<String,dynamic> toFirestore(){
    Map<String,dynamic> temp={
      "name":name,
      "description":description,
      "shortDesc":shortDesc,
      "imagePath":imagePath,
      "id":id
    };
    return temp;
  }
}
String roundReviews(int reviews){
  if (reviews<=100){
    return reviews.toString();
  }
  else{
    String str=reviews.toString();
    String newStr="";
    newStr+=str[0];
    for (int i=1;i<str.length;i++){
      newStr+="0";
    }
    return "$newStr+";
  }
}
Map<int, FoodItem> availFood={};

void addFood(FoodItem temp){
  availFood[temp.id]=temp;
}

// void initList(){
//   addFood(FoodItem(name: "Chocolate Cake",
//       description: "Chocolate cake typically includes ingredients like flour, sugar, cocoa powder, baking soda, baking powder, salt, eggs, milk, oil or butter, and vanilla extract. The ingredients might vary slightly depending on the recipe, and some recipes may also include coffee or sour cream for added flavor and moisture.",
//       shortDesc: "Chocolate, egg",
//       rating: 4.67,
//       reviews: 3216,
//       imagePath: "assets/images/chocolate_cake.jpg",
//       id: 1
//   ));
//   addFood(FoodItem(name: "Red n Hot Pizza",
//       description: "Red n Hot Pizza is a type of pizza that typically features a thin or thick crust topped with tomato sauce, mozzarella cheese, and various other toppings. These toppings can include pepperoni, sausage, mushrooms, onions, bell peppers, olives, and more, depending on personal preference. The name 'Red n Hot' suggests that the pizza may have a spicy element, which could come from ingredients like jalapeños, red pepper flakes, or spicy sausage. Overall, Red n Hot Pizza offers a flavorful and satisfying combination of ingredients that is popular among pizza lovers.",
//       shortDesc: "Spicy chicken, beef",
//       rating: 4.2,
//       reviews: 187,
//       imagePath: "assets/images/pizza.jpg",
//       id: 11
//   ));
//   addFood(FoodItem(name: "Greek Salad",
//       description: "Greek Salad with baked salmon combines crisp lettuce, cherry tomatoes, cucumber, Kalamata olives, and red onions, tossed in a zesty dressing. Topped with tender baked salmon, it offers a refreshing Mediterranean-inspired dish with a protein-packed twist.",
//       shortDesc: "with backed salmon",
//       rating: 4.2342,
//       reviews: 82,
//       imagePath: "assets/images/chocolate_cake.jpg",
//       id: 111
//   ));
//   addFood(FoodItem(name: "StrawBerry Ice Cream",
//       description: "Strawberry Ice Cream combines rich cream with the vibrant flavor of ripe strawberries, creating a luscious frozen treat. Made with fresh strawberry puree, creamy dairy, and a touch of sweetness, each spoonful bursts with fruity goodness and creamy indulgence.",
//       rating: 4.67,
//       reviews: 3216,
//       imagePath: "assets/images/chocolate_cake.jpg",
//       id: 1111
//   ));
//   addFood(FoodItem(name: "Hot Pizza",
//       description: "Hot Pizza is a type of pizza that typically features a thin or thick crust topped with tomato sauce, mozzarella cheese, and various other toppings. These toppings can include pepperoni, sausage, mushrooms, onions, bell peppers, olives, and more, depending on personal preference.",
//       shortDesc: "Taste our Hot Pizza",
//       rating: 4.67,
//       reviews: 3216,
//       imagePath: "assets/images/pizza.jpg",
//       id: 11111
//   ));
//   addFood(FoodItem(name: "Chhole Bhature",
//       description: "Chhole Ice Cream combines rich cream with the vibrant flavor of ripe strawberries, creating a luscious frozen treat. Made with fresh strawberry puree, creamy dairy, and a touch of sweetness, each spoonful bursts with fruity goodness and creamy indulgence.",
//       shortDesc: "It's Chhole Bature, what more do you want?",
//       rating: 4.67,
//       reviews: 3216,
//       imagePath: "assets/images/chholebhature.jpg",
//       id: 111111
//   ));
//   addFood(FoodItem(name: "Aloo Paratha",
//       description: "Aloo Ice Cream combines rich cream with the vibrant flavor of ripe strawberries, creating a luscious frozen treat. Made with fresh strawberry puree, creamy dairy, and a touch of sweetness, each spoonful bursts with fruity goodness and creamy indulgence.",
//       shortDesc: "Paratha stuffed with potatoes",
//       rating: 4.67,
//       reviews: 3216,
//       imagePath: "assets/images/alooparatha.jpg",
//       id: 1111111
//   ));
//   addFood(FoodItem(name: "Chicken Burger",
//       description: "Chicken Ice Cream combines rich cream with the vibrant flavor of ripe strawberries, creating a luscious frozen treat. Made with fresh strawberry puree, creamy dairy, and a touch of sweetness, each spoonful bursts with fruity goodness and creamy indulgence.",
//       shortDesc: "A classic chicken burger overflowing with savoury sauces and juicy veggies",
//       rating: 4.67,
//       reviews: 3216,
//       imagePath: "assets/images/burger.jpg",
//       id: 11111111
//   ));
// }
Future<void> initList() async {
  await db
      .collection('foods')
      .get()
      .then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          addFood(FoodItem.fromFirestore(docSnapshot,null));
        }
        print("fetched foods");
  });
}
void printAvail(){
  for (FoodItem item in availFood.values){
    if (kDebugMode) {
      print(item.name);
    }
    print(item.id);
    print(item.shortDesc);
    print(item.description);
    print(item.rating);
    print(item.reviews);
  }
}

Map<int, int> cart={};
void addToCart(int id, int qty){
  cart[id]=qty;
}
void initCart(){
  addToCart(availFood.keys.first, 3);
  addToCart(availFood.keys.last, 5);
}
void printCart(){
  for (int id in cart.keys){
    print(availFood[id]?.name);
    print(cart[id]);
  }
}
Map<int,FoodItem> popular={};
Map<int,FoodItem> newest={};
List<int> favourites=cart.keys.toList();
void initPopNew(){
  popular=Map.fromIterables(
      availFood.keys.skip(0).take(5),
      availFood.values.skip(0).take(5)
  );
  newest=Map.fromIterables(
      availFood.keys.skip(5),
      availFood.values.skip(5)
  );
}