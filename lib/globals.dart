import 'dart:ffi';

import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:localstore/localstore.dart';
import 'package:flutter/material.dart';
import 'foodclass.dart';
import 'dart:io';
bool isSignedIn=false;
bool checkedSigned=false;
FirebaseFirestore db= FirebaseFirestore.instance;
final localDb = Localstore.instance;
Profile? userProfile;
String docPath="";
File? selectedImage;

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
      Map<String, dynamic> data,
      ) {
    return Profile(
      name: data?['name'],
      phoneNo: data?['phoneNo'],
      gender: data?['gender'],
      height: data?['height'],
      weight: data?['weight'],
      medHistory: data?['medHistory'],
      dob: data?['dob'],
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
Future<void> fetchUser() async{
  Map<String,dynamic>? data= await localDb.collection("data").doc("user").get();
  if (data==null){
    print("data not stored bfore");
    if (FirebaseAuth.instance.currentUser!=null) {
      await db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) async {
        data=value.data();

        if (data!=null) {
          print("data fetching from server");
          userProfile = Profile.fromFirestore(data!);
          var storageRef = FirebaseStorage.instance.ref().child('user_images/${FirebaseAuth.instance.currentUser!.uid}');
          selectedImage=File('$docPath/pfp.jpg');
          final downloadTask = storageRef.writeToFile(selectedImage!);
          await downloadTask.whenComplete(() => print('downloaded pfp'));
          selectedImage=File('$docPath/pfp.jpg');
        }
      });
    }
  }
  else{
    print("data stored bfore");
    userProfile=Profile.fromFirestore(data);
    selectedImage = File('$docPath/pfp.jpg');
  }
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
Future<List<num?>> fetchAvgRating(int fid) async{
  double? avg;
  int? reviews;
  var query=db
      .collection('ratings')
      .where("fid", isEqualTo: fid);
  await query
      .count()
  .get()
  .then((value) {reviews=value.count;});
  await query
      .aggregate(average("rating"))
      .get()
      .then((aggregateQuerySnapshot) {
        avg=aggregateQuerySnapshot.getAverage("rating");
        print("avg rating for ${availFood[fid]?.name} = $avg,count = $reviews");
  });
  return [avg,reviews];
}
void testFetch(){
  int fid=availFood.keys.firstWhere((element) => availFood[element]!.name.toLowerCase().trim()=="Hot Pizza".toLowerCase().trim());
  fetchAvgRating(fid);
}
void addRating(int fid,double rating,String review) async{
  bool isExists=false;
  String docId="";
  Map<String,dynamic> rate={
    "fid":fid,
    "uid":FirebaseAuth.instance.currentUser!.uid,
    "rating":rating,
    "review":review,
  };
  try{
    await db
        .collection('ratings')
        .where("fid", isEqualTo: fid)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
      }
      if (querySnapshot.size != 0) {
        print("Rating already exists");
        isExists = true;
        docId = querySnapshot.docs.first.id;
      }
    });
  } catch (e){
    print(e);
  }
  if (isExists){
    print("update $fid ${FirebaseAuth.instance.currentUser!.uid} ${availFood[fid]?.name}");
    try{
      await db.collection('ratings').doc(docId).set(rate).then((value) {
        print(
            "Rating added with fid $fid and uid ${FirebaseAuth.instance.currentUser!.uid} for Food ${availFood[fid]?.name}");
      });
    }catch (e){
      print(e);
    }
  }
  else{
    print("create $fid ${FirebaseAuth.instance.currentUser!.uid} ${availFood[fid]?.name}");
    try{
      await db.collection('ratings').add(rate).then((value) {
        print(
            "Rating added with fid $fid and uid ${FirebaseAuth.instance.currentUser!.uid} for Food ${availFood[fid]?.name}");
      });
    }catch (e){
      print(e);
    }
  }
}
void testRating(){
  int fid=availFood.keys.firstWhere((element) => availFood[element]!.name.toLowerCase().trim()=="Hot Pizza".toLowerCase().trim());
  double rating=4.6;
  String review="Very Good. Liked it a lot.";
  addRating(fid, rating, review);
}
Future<void> initDatabase() async {
  print("starting globals");
  var dir = await getApplicationDocumentsDirectory();
  docPath=dir.path;
  print('docPath = $docPath');

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