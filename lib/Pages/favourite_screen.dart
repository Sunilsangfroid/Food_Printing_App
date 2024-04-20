// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../foodclass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FoodDeliveryScreen(),
    );
  }
}

class FoodDeliveryScreen extends StatefulWidget {
  const FoodDeliveryScreen({super.key});

  @override
  _FoodDeliveryScreenState createState() => _FoodDeliveryScreenState();
}

class _FoodDeliveryScreenState extends State<FoodDeliveryScreen> {
  void deleteFromFs(int id) {
    var index = favourites.indexOf(id);
    SnackBar snackbar= SnackBar(content: Text("${availFood[id]!.name} has been removed from Favourites"),
      duration: const Duration(seconds: 3),action: SnackBarAction(label: "Undo",onPressed: (){
        setState(() {
          favourites.insert(index,id);
        });}),);
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      favourites.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color defaultBlue = Theme.of(context).primaryColor;

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        child: BackButton(
          color: Colors.black,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 31),
            const Center(
              child: Text(
                "Favourites",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  for (int id in favourites)
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 300,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    availFood[id]!.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton(
                                onPressed: () => deleteFromFs(id),
                                icon: const Icon(Icons.close),
                                color: defaultBlue,
                                iconSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                availFood[id]!.name,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
