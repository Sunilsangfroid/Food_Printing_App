import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  VoidCallback func = (){};

  DrawerWidget(VoidCallback func){

    this.func = func;
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              accountName: Text("Ch.Sunil Patra",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              accountEmail: Text("sunilsangfroid@gmail.com",style: TextStyle(fontSize: 16),),
              currentAccountPicture: CircleAvatar(backgroundImage: AssetImage("images/avatar.png")),
              margin:EdgeInsets.only(bottom: 1),
            ),
          ),
          ListTile(
            onTap: (){Navigator.pushNamed(context,"/");},
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.red,
            ),
            title: Text("Home",style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold,
            ),),
          ),
          ListTile(
            onTap: (){Navigator.pushNamed(context,"/profile");},
            leading: Icon(
              CupertinoIcons.person,
              color: Colors.red,
            ),
            title: Text("My Account",style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold,
            ),),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.cart_fill,
              color: Colors.red,
            ),
            title: Text("My Orders",style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold,
            ),),
          ),
          ListTile(
            onTap: (){
              // Navigator.pushNamed(context,"/aiassi");
              },
            leading: Icon(
              CupertinoIcons.chat_bubble,
              color: Colors.red,
            ),
            title: Text("Chatbot",style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold,
            ),),
          ),
          ListTile(
            onTap: () async {await Navigator.pushNamed(context,"/favourite"); func();},
            leading: Icon(
              CupertinoIcons.heart_fill,
              color: Colors.red,
            ),
            title: Text("Favourites",style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold,
            ),),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.settings,
              color: Colors.red,
            ),
            title: Text("Setting",style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold,
            ),),
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text("Log Out",style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold,
            ),),
          )
        ],
      ),
    );
  }
}