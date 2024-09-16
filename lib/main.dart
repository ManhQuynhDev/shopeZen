import 'package:flutter/material.dart';
import 'package:shop_zen/screens/add_address_screen.dart';
import 'package:shop_zen/screens/add_card_screen.dart';
import 'package:shop_zen/screens/add_reviews_screen.dart';
import 'package:shop_zen/screens/cart_screen.dart';
import 'package:shop_zen/screens/choose_sign_up.dart';
import 'package:shop_zen/screens/details_screen.dart';
import 'package:shop_zen/screens/finish_screen.dart';
import 'package:shop_zen/screens/home_screen.dart';
import 'package:shop_zen/screens/login_screen.dart';
import 'package:shop_zen/screens/reviews_screen.dart';
import 'package:shop_zen/screens/sign_up_screen.dart';
import 'package:shop_zen/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/chooseSignUp': (context) => ChooseSignUp(),
        '/signUpScreen': (context) => SignUpScreen(),
        '/loginScreen': (context) => LoginScreen(),
      },
    );
  }
}

class NavigatorApp extends StatefulWidget {
  const NavigatorApp({super.key});

  @override
  State<NavigatorApp> createState() => _NavigatorAppState();
}

class _NavigatorAppState extends State<NavigatorApp> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    Text('Favorite'),
    Text('Cart'),
    Text('Payment'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorite'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.paypal_sharp),
              label: 'Payment',
            )
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 5.0,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
