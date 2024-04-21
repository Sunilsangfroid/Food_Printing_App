// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'foodclass.dart';

const defaultBlue = Color(0xff4c7efe);
const starColor = Color(0xffffc529);


class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  void incrementCounter(){
    setState(() {
      if (qty>=99){
        qty=99;
      }
      else {
        qty = qty + 1;
      }
    });
  }
  void decrementCounter(){
    setState(() {
      if (qty<=0){
        qty=0;
      }
      else {
        qty = qty - 1;
      }
    });
  }
  void constructSnackbar(){
    snackbar= SnackBar(content: Text("${chococake.name} has been added to Favourites"),
      duration: const Duration(seconds: 3),action: SnackBarAction(label: "Undo",onPressed: (){
        setState(() {
          favourite=false;
          favourites.remove(id);
        });}),);
  }
  void favouriteItem(){
    setState(() {
      favourite=!favourite;
    });
    if (favourite) {
      favourites.add(id);
    } else {
      favourites.remove(id);
    }
    if (favourite)ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
  // int id=availFood.keys.first;
  int id=-1;
  int qty=0;
  bool favourite=false;
  double flavor=0.5;
  String calories="";
  SnackBar snackbar=const SnackBar(content: Text(""));
  FoodItem chococake=FoodItem();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    id = id<0 ? ModalRoute.of(context)!.settings.arguments as int : id;
    print("id = $id");
    favourite=favourites.contains(id);

    if (qty==0 && cart.keys.contains(id)) {
      qty = cart[id]!;
    }

    constructSnackbar();
    chococake=availFood[id]!;

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 10.0),
        child: BackButton(
          color: Colors.black,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                        aspectRatio: 16/11,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              chococake.imagePath,
                              fit: BoxFit.fitWidth,
                            )
                        )
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(onPressed: favouriteItem, icon: const Icon(Icons.favorite),color: favourite?Colors.pink:Colors.grey[600],)
                  )
                ],
              ),
              const SizedBox(height: 10.0,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  chococake.name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star_rate_rounded,color: starColor,),
                  Text(
                    " ${chococake.rating.toStringAsFixed(1)}  ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "(${roundReviews(chococake.reviews)})  ",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    child: const Text("See Review",style: TextStyle(color: Colors.lightBlue,decoration: TextDecoration.underline,decorationColor: Colors.lightBlue),),
                    onTap: (){},
                  )
                ],
              ),
              const SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("  Quantity",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400
                  ),),
                  Row(
                    children: [
                      IconButton.outlined(
                        onPressed: decrementCounter,
                        icon: const Icon(Icons.remove),
                        color: defaultBlue,
                        style: OutlinedButton.styleFrom(side: const BorderSide(color: defaultBlue)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 4.0),
                        child: Text(qty.toString().padLeft(2,'0'),style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0
                        ),),
                      ),
                      IconButton.filled(
                        onPressed: incrementCounter,
                        icon: const Icon(Icons.add),
                        //style: FilledButton.styleFrom(backgroundColor: defaultBlue),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              Text(chococake.description,textAlign: TextAlign.left,style: const TextStyle(
                fontSize: 17.0,
                color:Colors.grey,
              ),),
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sweet", style: TextStyle(fontSize: 22)),
                    Text("Spicy", style: TextStyle(fontSize: 22))
                  ],
                ),
              ),
              Slider(
                  value: flavor,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (double newValue){
                    setState(() {
                      flavor=newValue;
                    });
                  }
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("  Calories",style: TextStyle(
                  fontSize: 25,
                ),
                ),
              ),
              TextField(
                onChanged: (String newVal){
                  setState(() {
                    calories=newVal;
                  });
                },
                onTapOutside: (PointerDownEvent event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },

                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,width: 0.5)),
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],),
              const SizedBox(height: 20,),
              FilledButton(onPressed: () async {setState(() {cart[id]=qty;});await Navigator.pushNamed(context, '/cart');setState(() {});}, child: Row(mainAxisSize: MainAxisSize.min,children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white,),
                  child: const Icon(Icons.shopping_bag_rounded,color: defaultBlue,),
                ),
                const SizedBox(width: 10,),
                const Text("ADD TO CART")
              ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
