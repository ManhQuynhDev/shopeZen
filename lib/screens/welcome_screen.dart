import 'package:flutter/material.dart';
import 'package:shop_zen/screens/choose_sign_up.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Shopzen',
            style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xff4A4E69)),
          ),
          Image.asset(
            'assets/images/welcome_image.png',
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ChooseSignUp.CHOOSE_SIGN_UP);
            },
            child: Container(
              width: 82,
              height: 82,
              decoration:
                  BoxDecoration(color: Color(0xff4A4E69), shape: BoxShape.circle),
              child: Icon(
                Icons.chevron_right_sharp,
                color: Colors.white,
                size: 34,
              ),
            ),
          )
        ],
      ),
    );
  }
}
