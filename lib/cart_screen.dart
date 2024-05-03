import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'foodclass.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void incrementCounter(int id) {
    setState(() {
      if (cart[id]! >= 9) {
        cart[id] = 9;
      } else {
        cart[id] = (cart[id]!) + 1;
      }
    });
  }

  void decrementCounter(int id) {
    setState(() {
      if (cart[id]! > 1) {
        cart[id] = cart[id]! - 1;
      }
      // Ensure minimum quantity is 1
      if (cart[id]! <= 0) {
        cart[id] = 1;
      }
    });
  }

  void deleteFromCart(int id) {
    setState(() {
      cart.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    Color defaultBlue = Theme.of(context).primaryColor;

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
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
            const SizedBox(
              height: 31,
            ),
            const Center(
              child: Text(
                "Cart",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView(
                children: [
                  for (int id in cart.keys)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
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
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      availFood[id]!.name,
                                      style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: IconButton(
                                        onPressed: () => deleteFromCart(id),
                                        icon: const Icon(
                                          Icons.close,
                                        ),
                                        color: defaultBlue,
                                        iconSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  availFood[id]!.shortDesc,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Quantity",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    Transform.scale(
                                      scale: 0.85,
                                      child: IconButton.outlined(
                                        onPressed: () => decrementCounter(id),
                                        icon: const Icon(
                                          Icons.remove,
                                        ),
                                        color: defaultBlue,
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            color: defaultBlue,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 4.0),
                                      child: Text(
                                        cart[id].toString().padLeft(2, '0'),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.85,
                                      child: IconButton.filled(
                                        onPressed: () => incrementCounter(id),
                                        icon: const Icon(
                                          Icons.add,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //testing reviewing
                // Navigator.pushNamed(context, '/feedback', arguments: cart.keys.first);
                Navigator.pushNamed(context, '/connect', arguments: availFood[cart.keys.first]!.gcodePath);
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
