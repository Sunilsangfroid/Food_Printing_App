import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:
      Padding(
        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 5),
        child:Row(
          children: [

          // Single Item
          // for(int i=0;i<10;i++)
          Padding(padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color:Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0,3),
                )
              ]

            ),
            child: Image.asset(
                "images/pizza.jpg",
                 height: 80,
                 width: 90,

            ),
          ),
         ),

          // Single Item
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      )
                    ]

                ),
                child: Image.asset("images/burger.jpg",
                  height: 80,
                  width: 90,),
              ),
            ),

            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      )
                    ]

                ),
                child: Image.asset(
                    "images/alooparatha.jpg",
                  height: 80,
                  width: 90,

                ),
              ),
            ),

            // Single Item

            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      )
                    ]

                ),
                child: Image.asset("images/biryani.jpg"),
                height: 80,
                width: 90,
              ),
            ),

            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      )
                    ]

                ),
                child: Image.asset(
                    "images/frenchfries.jpg",
                  height: 80,
                  width: 90,

                ),
              ),
            ),

            // Single Item

            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      )
                    ]

                ),
                child: Image.asset("images/sandwich.jpg"),
                height: 80,
                width: 90,
              ),
            ),

            // Single Item

            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      )
                    ]

                ),
                child: Image.asset("images/chholebhature.jpg"),
                height: 80,
                width: 90,
              ),
            ),

            // Single Item

            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      )
                    ]

                ),
                child: Image.asset("images/poha.jpg"),
                height: 80,
                width: 90,
              ),
            ),





          ]),
      ),
    );
  }
}