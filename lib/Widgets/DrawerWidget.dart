// ignore_for_file: file_names, must_be_immutable, use_build_context_synchronously, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itrm_screen/globals.dart';

class DrawerWidget extends StatefulWidget {
  VoidCallback func = () {};

  DrawerWidget(this.func, {super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              accountName: Text(
                (userProfile != null) ? userProfile!.name : "",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              accountEmail: Text(
                FirebaseAuth.instance.currentUser!.email!,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                  foregroundImage: (selectedImage != null)
                      ? FileImage(selectedImage!)
                      : null,
                  backgroundImage:
                      const AssetImage("assets/images/avatar.png")),
              margin: const EdgeInsets.only(bottom: 1),
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
              Navigator.pushNamed(context, "/profile", arguments: () {
                setState(() {});
              });
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
              CupertinoIcons.printer,
              color: Colors.blue,
            ),
            title: const Text(
              "Printed Food",
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
            onTap: () async {
              await Navigator.pushNamed(context, "/favourite");
              widget.func();
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
          // ListTile(
          //   onTap: () {
          //     Navigator.pushNamed(context, "/setting");
          //   },
          //   leading: const Icon(
          //     CupertinoIcons.settings,
          //     color: Colors.blue,
          //   ),
          //   title: const Text(
          //     "Settings",
          //     style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black),
          //   ),
          // ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/help");
            },
            leading: const Icon(
              CupertinoIcons.question,
              color: Colors.blue,
            ),
            title: const Text(
              "Help & FAQ",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.pushNamed(context, "/test");
          //   },
          //   leading: const Icon(
          //     CupertinoIcons.question,
          //     color: Colors.blue,
          //   ),
          //   title: const Text(
          //     "testing",
          //     style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black),
          //   ),
          // ),
          ListTile(
            onTap: () async {
              try {
                switch (FirebaseAuth
                    .instance.currentUser?.providerData[0].providerId) {
                  case 'password':
                    await FirebaseAuth.instance.signOut();
                    localDb.collection('data').doc('user').delete();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Signed out successfully.'),
                      ),
                    );
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (route) => false);
                    break;
                  case 'google.com':
                    await FirebaseAuth.instance.signOut();
                    await GoogleSignIn().signOut();
                    print(FirebaseAuth.instance.currentUser);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Signed out successfully.'),
                      ),
                    );
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (route) => false);
                    break;
                }
              } on FirebaseAuthException catch (e) {
                print(e);
              } catch (e) {
                print(e);
              }
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
          ),
        ],
      ),
    );
  }
}
