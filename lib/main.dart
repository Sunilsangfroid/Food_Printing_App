// import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'Pages/notification.dart';
import 'Pages/setting.dart';
import 'Pages/myaccount.dart';
import 'Pages/sigin.dart';
import 'Pages/signup.dart';
import 'Pages/welcome.dart';
import 'Pages/search.dart';
import 'item_screen.dart';
import 'cart_screen.dart';
import 'colors_ext.dart';
import 'foodclass.dart';
// import 'Pages/forget_password.dart';
import 'Pages/HomePage.dart';
import 'Pages/favourite_screen.dart';
// import 'Pages/chatbot.dart';
import 'Pages/feedback _page.dart';
import 'Pages/chats.dart';
import 'Pages/help.dart';
import 'package:itrm_screen/globals.dart' as globals;

const defaultBlue = Color(0xff4c7efe);
const starColor = Color(0xffffc529);

Future<void> initFireBase() async {
  print("starting FireBase");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("initialized Firebase");
  checkSigned();
  await globals.initDatabase();
  await initList();
  printAvail();
  initCart();
  // printCart();
  initPopNew();
}
void checkSigned(){
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    globals.checkedSigned=true;
    if (user == null) {
      print('User is currently signed out!');
      globals.isSignedIn=false;
    } else {
      print('User is signed in!');
      print("${user.uid},${user.email}");
      globals.isSignedIn=true;
    }
  });
}
MaterialApp myApp=MaterialApp(
  theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF5F5F3),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: defaultBlue.toMaterialColor(),
        accentColor: defaultBlue,
        cardColor: defaultBlue,
        backgroundColor: Colors.white,
      )),
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  // initialRoute:'/profile',
  routes: {
    '/': (context) =>  WelcomeScreen(),
    '/signup': (context) => const SignUpScreen(),
    '/signin': (context) => const SignInScreen(),
    // '/forget_password': (context) => ForgetPasswordScreen(),
    "/home": (context) => const HomePage(),
    '/item': (context) => const ItemScreen(),
    '/cart': (context) => const CartScreen(),
    '/favourite': (context) => const FoodDeliveryScreen(),
    '/feedback': (context) => const UI22(),
    '/profile': (context) => const MyAccountPage(),
    '/setting': (context) => const SettingsPage(),
    '/notification': (context) => const NotificationScreen(),
    '/aiassi': (context) => const ChatScreen(),
    '/help': (context) => const HelpFAQPage(),
    '/search': (context) => const SearchPage()
  },
);
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBase();
  runApp(myApp);
}
