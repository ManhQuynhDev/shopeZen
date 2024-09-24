import 'package:flutter/material.dart';
import 'package:shop_zen/screens/login_screen.dart';
import 'package:shop_zen/screens/sign_up_screen.dart';

class ChooseSignUp extends StatelessWidget {
  const ChooseSignUp({super.key});

  static String CHOOSE_SIGN_UP = '/chooseSignUp';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.topLeft,
                width: double.infinity,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  child: Icon(Icons.chevron_left_outlined),
                ),
              ),
            ),
            const Text(
              'Shopzen',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4A4E69)),
            ),
            Image.asset(
              'assets/images/welcome_image.png',
              width: double.infinity,
              height: size.height * 0.4,
              fit: BoxFit.contain,
            ),
            const Text(
              'Get Your Stuffs \nHere !',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.SIGN_UP_SCREEN);
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(191, 48),
                    backgroundColor: Color(0xff4A4E69),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                child: const Text(
                  'Create account',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.LOGIN_SCREEN);
              },
              child: RichText(
                  text: const TextSpan(
                      text: 'Hava an account?',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Login',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff4A4E69)))
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
