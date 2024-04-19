import '../Widgets/DrawerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/AppBarWidget.dart';
import '../Widgets/CategoriesWidget.dart';
import '../Widgets/NewestItemsWidget.dart';
import '../Widgets/PopularItemsWidget.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
    body: ListView(
      children: [
        //Custom App Bar Widget
        AppBarWidget(),

        //search
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color:Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0,3),
                ),
              ]),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(children: [
                  Icon(
                    CupertinoIcons.search,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    child: Padding(
                      padding:EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "What would you like to eat ?",
                          border:InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  // Icon(Icons.filter_list),
                ],
              ),
            ),
          ),

        ),

        //Category
        Padding(
          padding: EdgeInsets.only(top: 10,left: 8),
          child: Text(
            "Categories",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
            ),
          ),
        ),
        CategoriesWidget(),
        Padding(
          padding: EdgeInsets.only(top: 0,left: 10),
          child: Text(
            "Popular",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),

        //Popular Items Widget
        PopularItemsWidget(),

        // Newest Items
        Padding(
          padding: EdgeInsets.only(top: 0,left: 10),
          child: Text(
            "Newest",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),

        // Newest Item Widget
        NewestItemsWidget(),
      ],
    ),
    drawer: DrawerWidget(),
    floatingActionButton: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color:Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0,3),
            ),
          ]
      ),
      child: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context,"/cart");
        },
        child: Icon(
          CupertinoIcons.cart,
          size: 28,
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
      ),
    ),
    );
  }
}