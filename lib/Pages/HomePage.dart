import '../Widgets/DrawerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/AppBarWidget.dart';
import '../Widgets/CategoriesWidget.dart';
import '../Widgets/NewestItemsWidget.dart';
import '../Widgets/PopularItemsWidget.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
    body: ListView(
      children: [
        //Custom App Bar Widget
        const AppBarWidget(),

        //search
        Padding(
          padding: const EdgeInsets.symmetric(
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
                  offset: const Offset(0,3),
                ),
              ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(children: [
                  const Icon(
                    CupertinoIcons.search,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: Padding(
                      padding:const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
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
        const Padding(
          padding: EdgeInsets.only(top: 10,left: 8),
          child: Text(
            "Categories",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
            ),
          ),
        ),
        const CategoriesWidget(),
        const Padding(
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
        const Padding(
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
        const NewestItemsWidget(),
      ],
    ),
    drawer: const DrawerWidget(),
    floatingActionButton: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color:Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0,3),
            ),
          ]
      ),
      child: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context,"/cart");
        },
        backgroundColor: Colors.white,
        child: const Icon(
          CupertinoIcons.cart,
          size: 28,
          color: Colors.blue,
        ),
      ),
    ),
    );
  }
}