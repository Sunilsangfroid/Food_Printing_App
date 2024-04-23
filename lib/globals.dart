import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'foodclass.dart';
bool isSignedIn=false;
bool checkedSigned=false;
FirebaseFirestore db= FirebaseFirestore.instance;

class Profile{
  String name;
  String phoneNo;
  String gender;
  int? height=null;
  int? weight=null;
  String medHistory;

  Profile({required this.name, this.phoneNo="", this.gender="", this.height, this.weight,this.medHistory=""});

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

  Map<String,dynamic> toFirestore(){
    Map<String,dynamic> temp={
      "name":name,
      "phoneNo":phoneNo,
      "gender":gender,
      "height":height,
      "weight":weight,
      "bmi":(height!=null && weight!=null)?(weight!/(height!*height!/10000)):null,
      "medHistory":medHistory,
      "uid":FirebaseAuth.instance.currentUser!.uid
    };
    return temp;
  }
}
void addUser(Profile user) async{
  var map=user.toFirestore();
  await db.collection("users").doc(map["uid"]).set(map).whenComplete(() => print('DocumentSnapshot added with ID: ${map["uid"]}'));
}
void addFood(FoodItem foodItem) async{

}
void initDatabase() async{
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
    Profile user2 = Profile(
      name: "Pritam",
      phoneNo: "9348920244",
      gender: "Male",
      height: 160,
      weight: 50,
      medHistory: "diabetes",
    );
    addUser(user2 as Profile);
  } catch (e) {
    print('Error: $e');
  }
  print("accessed Database");
}
void main(){
  print("starting globals");
  // initDatabase();
}