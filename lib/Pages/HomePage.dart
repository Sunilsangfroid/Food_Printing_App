import 'dart:io';

import 'package:itrm_screen/foodclass.dart';

import '../Widgets/DrawerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/AppBarWidget.dart';
import '../Widgets/CategoriesWidget.dart';
import '../Widgets/NewestItemsWidget.dart';
import '../Widgets/PopularItemsWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  Future<bool?> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () => exit(0),
          child: Text('Yes'),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
    child: Scaffold(
      body: ListView(
        children: [
          // Custom App Bar Widget
          const AppBarWidget(),

          // Search
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
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.search,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 10, // Adjust the width for spacing
                    ),
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (search) {
                          //Search here
                          Navigator.pushNamed(context, "/search",arguments: search);
                        },
                        decoration: const InputDecoration(
                          hintText: "What would you like to eat ?",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // Icon(Icons.filter_list),
                  ],
                ),
              ),
            ),
          ),

          // Category
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 8),
            child: Text(
              "Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const CategoriesWidget(),

          // Popular
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              "Popular",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Popular Items Widget
          const PopularItemsWidget(),

          // Newest
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              "Newest",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),

          // Newest Item Widget
          Flexible(
            child: NewestItemsWidget(
              key: ValueKey(favourites),
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(() {
        setState(() {});
        print(favourites);
        print("hi");
      }),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/cart");
          },
          backgroundColor: Colors.white,
          child: const Icon(
            CupertinoIcons.cart,
            size: 28,
            color: Colors.blue,
          ),
        ),
      ),
    ));
  }
}