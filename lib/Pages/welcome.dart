import 'package:firebase_auth/firebase_auth.dart';

import '../Pages/sigin.dart';
import '../Pages/signup.dart';
import '../Widgets/custom_scaffold.dart';
import '../Widgets/welcome_button.dart';
import 'package:flutter/material.dart';
import 'package:itrm_screen/globals.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  bool _isLoading=false;

  void check(context) async {
    if (isSignedIn)_isLoading=true;
    await Future.delayed(Duration(seconds: 1), () {
        if (isSignedIn){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signed in as ${FirebaseAuth.instance.currentUser?.email}.'),
            ),
          );
          fetchUser();
          print("switch");Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        }
        _isLoading=false;
    });
  }
  @override
  build(BuildContext context) {
    check(context);
    return CustomScaffold(
      child: Stack(
        children: [
          Column(
          children: [
            Flexible(
              flex: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 40.0),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: [
                      TextSpan(
                          text: 'Welcome !\n',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      TextSpan(
                          text: '\n To Indias first food printing app',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                    ]),
                  ),
                ),
              ),
            ),
            const Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    Expanded(
                      child: WelcomeButton(
                        buttonText: 'Sign in',
                        onTap: SignInScreen(),
                        color: Colors.white,
                        textColor: Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: WelcomeButton(
                        buttonText: 'Sign up',
                        onTap: SignUpScreen(),
                        color: Colors.white,
                        textColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
          _isLoading ? Center(child: CircularProgressIndicator()) : Container(),
        ]
      ),
    );
  }
}
