// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              accountName: Text(
                "Ch.Sunil Patra",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              accountEmail: Text(
                "sunilsangfroid@gmail.com",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.png")),
              margin: EdgeInsets.only(bottom: 1),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/home");
            },
            leading: const Icon(
              CupertinoIcons.home,
              color: Colors.blue,
            ),
            title: const Text(
              "Home",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/profile");
            },
            leading: const Icon(
              CupertinoIcons.person,
              color: Colors.blue,
            ),
            title: const Text(
              "My Account",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/cart");
            },
            leading: const Icon(
              CupertinoIcons.cart_fill,
              color: Colors.blue,
            ),
            title: const Text(
              "My Food",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/aiassi");
            },
            leading: const Icon(
              CupertinoIcons.chat_bubble,
              color: Colors.blue,
            ),
            title: const Text(
              "Chatbot",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/favourite");
            },
            leading: const Icon(
              CupertinoIcons.heart_fill,
              color: Colors.blue,
            ),
            title: const Text(
              "Favourites",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/setting");
            },
            leading: const Icon(
              CupertinoIcons.settings,
              color: Colors.blue,
            ),
            title: const Text(
              "Setting",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/signin");
            },
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.blue,
            ),
            title: const Text(
              "Log Out",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
