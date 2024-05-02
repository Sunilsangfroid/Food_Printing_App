import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Pages/feedback _page.dart';
import 'Pages/review.dart';
import 'Pages/notification.dart';
import 'Pages/setting.dart';
import 'Pages/myaccount.dart';
import 'Pages/sigin.dart';
import 'Pages/signup.dart';
import 'Pages/welcome.dart';
import 'Pages/search.dart';
import 'Pages/categoryPage.dart';
import 'item_screen.dart';
import 'cart_screen.dart';
import 'foodclass.dart';
import 'Pages/HomePage.dart';
import 'Pages/favourite_screen.dart';
import 'Pages/chats.dart';      
import 'Pages/help.dart';
import 'Pages/register.dart';
import 'firebase_options.dart';
import 'colors_ext.dart';
import 'globals.dart' as globals;

const defaultBlue = Color(0xff4c7efe);
const starColor = Color(0xffffc529);

Future<void> initFireBase() async {
  print("Starting Firebase initialization");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Firebase initialized");
  checkSigned();
  await globals.initDatabase();
  await initList();
  globals.testFetch();
  initCart();
  initPopNew();
}

void checkSigned() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    globals.checkedSigned = true;
    globals.isSignedIn = user != null;
    print(globals.isSignedIn
        ? 'User is signed in!'
        : 'User is currently signed out!');
    if (user != null) {
      print("User ID: ${user.uid}, Email: ${user.email}");
    }
  });
}

final myApp = MaterialApp(
  theme: ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF5F5F3),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: defaultBlue.toMaterialColor(),
      accentColor: defaultBlue,
      cardColor: defaultBlue,
      backgroundColor: Colors.white,
    ),
  ),
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => WelcomeScreen(),
    '/signup': (context) => const SignUpScreen(),
    '/signin': (context) => const SignInScreen(),
    '/home': (context) => const HomePage(),
    '/item': (context) => const ItemScreen(),
    '/review': (context) {
      final itemId = ModalRoute.of(context)!.settings.arguments as int;
      return ReviewScreen(itemId: itemId);
    },
    '/feedback': (context) => const FeedbackScreen(),
    '/cart': (context) => const CartScreen(),
    '/favourite': (context) => const FoodDeliveryScreen(),
    // '/feedback': (context) => const UI22(),
    '/profile': (context) => const MyAccountPage(),
    '/setting': (context) => const SettingsPage(),
    '/notification': (context) => const NotificationScreen(),
    '/aiassi': (context) => const ChatScreen(),
    '/help': (context) => const HelpFAQPage(),
    '/search': (context) => const SearchPage(),
    '/category': (context) => const CategoryPage(),
    '/register': (context) => const RegistrationPage(),
  },
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBase();
  runApp(myApp);
}
