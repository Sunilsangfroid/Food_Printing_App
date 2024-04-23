import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Map<String,dynamic> map(){
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
void addUser(Profile user){
  db.collection("users").add(user.map()).then((DocumentReference doc) =>
      print('DocumentSnapshot added with ID: ${doc.id}'));
}
