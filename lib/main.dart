// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:itrm_screen/Pages/chatbot.dart';
import 'Pages/myaccount.dart';
import 'item_screen.dart';
import 'cart_screen.dart';
import 'colors_ext.dart';
import 'foodclass.dart';
import 'Pages/CartPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/favourite_screen.dart';
import 'Pages/chatbot.dart';
// import 'Pages/feedback _page.dart';


const defaultBlue = Color(0xff4c7efe);
const starColor = Color(0xffffc529);

void main() {
  initList();
  printAvail();
  initCart();
  printCart();
  initPopNew();
  runApp(MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF5F5F3), colorScheme: ColorScheme.fromSwatch(
      primarySwatch: defaultBlue.toMaterialColor(),
      accentColor: defaultBlue,
    cardColor: defaultBlue,
    backgroundColor: Colors.white,
  )),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // initialRoute:'/profile',
      routes: {
        "/":(context) => HomePage(),
        '/item': (context) => const ItemScreen(),
        '/cart': (context) => const CartScreen(),
        '/favourite': (context) => FoodDeliveryScreen(),
        '/profile':(context) => MyAccountPage(),
        '/aiassi':(context) => ChatScreen(),
      },
      ));
}
