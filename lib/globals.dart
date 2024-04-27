import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'foodclass.dart';
import 'dart:io';
bool isSignedIn=false;
bool checkedSigned=false;
FirebaseFirestore db= FirebaseFirestore.instance;
Profile userProfile=Profile(name: "name");
class Profile{
  String name;
  String phoneNo;
  String gender;
  double? height=null;
  double? weight=null;
  String medHistory;
  String dob;
  String? email;
  

  Profile({required this.name, this.phoneNo="", this.gender="", this.height, this.weight,this.medHistory="",this.dob="",this.email=""});

  factory Profile.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Profile(
      name: data?['name'],
      phoneNo: data?['phoneNo'],
      gender: data?['gender'],
      height: data?['height'],
      weight: data?['weight'],
      medHistory: data?['medHistory'],
    );
  }

  Map<String,dynamic> toFirestore(String? imagePath){
    Map<String,dynamic> temp={
      "name":name,
      "phoneNo":phoneNo,
      "email":email,
      "dob":dob,
      "gender":gender,
      "height":height,
      "weight":weight,
      "bmi":(height!=null && weight!=null)?(weight!/(height!*height!/10000)):null,
      "medHistory":medHistory,
      "imageUrl":imagePath,
      "uid":FirebaseAuth.instance.currentUser!.uid
    };
    return temp;
  }
}
void addUser(Profile user,String imagePath) async{
  var map=user.toFirestore(imagePath);
  await db.collection("users").doc(map["uid"]).set(map).whenComplete(() => print('DocumentSnapshot added with ID: ${map["uid"]}'));
}
void testUser(){
  Profile user2 = Profile(
    name: "Pritam",
    phoneNo: "9348920244",
    gender: "Male",
    height: 160,
    weight: 50,
    medHistory: "diabetes",
  );
  addUser(user2 as Profile,"");
}
void pushFood(FoodItem foodItem) async{
  bool isExists=false;
  await db
      .collection('foods')
      .where("name", isEqualTo: foodItem.name)
      .get()
      .then((querySnapshot) {if (querySnapshot.size != 0){print("Food already exists");isExists=true;}});
  if (isExists){return;}
  availFood[foodItem.id]=foodItem;
  await db.collection("foods").add(foodItem.toFirestore()).then((documentSnapshot) =>
      print("Added Food with docID: ${documentSnapshot.id} and Name ${foodItem.name} and UniqueID ${foodItem.id}"));
}
void testFood(FoodItem foodItem) async{
  bool isUnique=false;
  int tempId=0;
  // tempId=UniqueKey().hashCode;
  while(!isUnique) {
    tempId=UniqueKey().hashCode;
    await db
        .collection('foods')
        .where("id", isEqualTo: tempId)
        .get()
        .then((querySnapshot) {
      isUnique = (querySnapshot.size == 0);print("notUnique");
    });
  }
  FoodItem temp=FoodItem(name: foodItem.name,
      description: foodItem.description,
      shortDesc: foodItem.shortDesc,
      rating: foodItem.rating,
      reviews: foodItem.reviews,
      imagePath: foodItem.imagePath,
      id: tempId
  );
  pushFood(temp);
}
Future<void> initDatabase() async {
  print("starting globals");

  print("starting Database");
  try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    User? user=FirebaseAuth.instance.currentUser;
    db= FirebaseFirestore.instance;
    if(user==null){
      print('User is not signed in.');
      return;
    }
    // print(availFood.length);
    // for (FoodItem foodItem in availFood.values) {
    //   testFood(foodItem);
    // }
    // testUser();

  } catch (e) {
    print('Error: $e');
  }
  print("accessed Database");
}