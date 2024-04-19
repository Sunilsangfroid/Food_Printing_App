import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import "../foodclass.dart";

class NewestItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          children: [
            // for(int i=0;i<10;i++)

            //Single Item
            for (int id in newest.keys)
            GestureDetector(
              onTap: (){Navigator.pushNamed(context, "/item",arguments: id);},
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: 380,
                  height: 150,
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      ),
                    ]
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 130,
                          child: Image.asset(
                            newest[id]!.imagePath,
                            height: 100,
                            width: 130,
                          ),
                        ),
                      ),
                      Container(
                        width: 190,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              newest[id]!.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
              
                            Text(
                              newest[id]!.shortDesc,
                              style: TextStyle(
                                fontSize: 14,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 18,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4),
                              itemBuilder:(context,_)=> Icon(
                                Icons.star,
                                color:Colors.blue,
                              ),
                              onRatingUpdate: (index){},
                            ),
                            Text(
                              "\$10",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
              
                        ],),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.blue,
                              size: 26,
                            ),
                            IconButton(onPressed: (){cart[id]=0;},
                              icon: Icon(
                                CupertinoIcons.cart,
                                color: Colors.blue,
                                size: 26,
                              ),)
                          ],
                        ),
                      ),
              
              
              
              
                    ],
                  ),
                ),
              
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      ),
                    ]
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/chholebhature.jpg",
                          height: 100,
                          width: 130,
                        ),
                      ),
                    ),
                    Container(
                      width: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Chhole bhature",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Taste Our Chhole bhature, We Provide Our Great Foods",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 18,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder:(context,_)=> Icon(
                              Icons.star,
                              color:Colors.blue,
                            ),
                            onRatingUpdate: (index){},
                          ),
                          Text(
                            "\$10",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.blue,
                            size: 26,
                          ),
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.blue,
                            size: 26,
                          ),
                        ],
                      ),
                    ),




                  ],
                ),
              ),

            ),


            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      ),
                    ]
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/alooparatha.jpg",
                          height: 100,
                          width: 130,
                        ),
                      ),
                    ),
                    Container(
                      width: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Aloo Paratha",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Taste Our Aloo Paratha, We Provide Our Great Foods",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 18,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder:(context,_)=> Icon(
                              Icons.star,
                              color:Colors.blue,
                            ),
                            onRatingUpdate: (index){},
                          ),
                          Text(
                            "\$10",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.blue,
                            size: 26,
                          ),
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.blue,
                            size: 26,
                          ),
                        ],
                      ),
                    ),




                  ],
                ),
              ),

            ),



            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      ),
                    ]
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/burger.jpg",
                          height: 100,
                          width: 130,
                        ),
                      ),
                    ),
                    Container(
                      width: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Chicken Burger",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Taste Our chicken burger, We Provide Our Great Foods",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 18,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder:(context,_)=> Icon(
                              Icons.star,
                              color:Colors.blue,
                            ),
                            onRatingUpdate: (index){},
                          ),
                          Text(
                            "\$10",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.blue,
                            size: 26,
                          ),
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.blue,
                            size: 26,
                          ),
                        ],
                      ),
                    ),




                  ],
                ),
              ),

            ),




            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      ),
                    ]
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/sandwich.jpg",
                          height: 100,
                          width: 130,
                        ),
                      ),
                    ),
                    Container(
                      width: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Hot Pizza",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Taste Our cheesy Sandwich, We Provide Our Great Foods",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 18,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder:(context,_)=> Icon(
                              Icons.star,
                              color:Colors.blue,
                            ),
                            onRatingUpdate: (index){},
                          ),
                          Text(
                            "\$10",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.blue,
                            size: 26,
                          ),
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.blue,
                            size: 26,
                          ),
                        ],
                      ),
                    ),




                  ],
                ),
              ),

            ),





            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      ),
                    ]
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/biryani.jpg",
                          height: 100,
                          width: 130,
                        ),
                      ),
                    ),
                    Container(
                      width: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Dum Biryani",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Taste Our spicy biryani, We Provide Our Great Foods",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 18,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder:(context,_)=> Icon(
                              Icons.star,
                              color:Colors.blue,
                            ),
                            onRatingUpdate: (index){},
                          ),
                          Text(
                            "\$10",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.blue,
                            size: 26,
                          ),
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.blue,
                            size: 26,
                          ),
                        ],
                      ),
                    ),




                  ],
                ),
              ),

            ),





            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 380,
                height: 150,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0,3),
                      ),
                    ]
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "images/poha.jpg",
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                    Container(
                      width: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Masala Poha",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Taste Our healthy poha, We Provide Our Great Foods",
                            style: TextStyle(
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 18,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder:(context,_)=> Icon(
                              Icons.star,
                              color:Colors.blue,
                            ),
                            onRatingUpdate: (index){},
                          ),
                          Text(
                            "\$10",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),


                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.blue,
                            size: 26,
                          ),
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.blue,
                            size: 26,
                          ),
                        ],
                      ),
                    ),




                  ],
                ),
              ),

            ),
          ],
        ),
      )
    );
  }
}