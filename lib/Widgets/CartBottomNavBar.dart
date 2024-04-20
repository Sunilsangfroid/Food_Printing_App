// ignore_for_file: file_names

import 'package:flutter/material.dart';
class CartBottomNavBar extends StatelessWidget{
  const CartBottomNavBar({super.key});

  @override
  Widget build(BuildContext context){
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 70,
        child: const Row(children: [
          Text(
            "Total",
            style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.blue),
          ),
        ],
        ),
      ),
    );
  }
}