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
  List<String> tags;
  final int id;
  // final id = UniqueKey().hashCode;

  FoodItem({this.name="",this.description="",this.shortDesc="",this.rating=0.0,this.reviews=0,this.imagePath="",this.tags=const <String>[],required this.id});
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
      tags: List<String>.from(data?["tags"]),
      id: data?['id']
    );
  }
  Map<String,dynamic> toFirestore(){
    Map<String,dynamic> temp={
      "name":name,
      "description":description,
      "shortDesc":shortDesc,
      "imagePath":imagePath,
      "tags":tags,
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