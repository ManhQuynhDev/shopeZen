import 'package:flutter/material.dart';
import 'package:shop_zen/screens/choose_sign_up.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    //Thời gian
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

     _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _animation = Tween<Offset>(begin: Offset(-2, 0), end: Offset(0, 0))
        .animate(_curvedAnimation);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SlideTransition(
            position: _animation,
            child: const Text(
              'Shopzen',
              style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4A4E69)),
            ),
          ),
          SlideTransition(
            position: _animation,
            child: Image.asset(
              'assets/images/welcome_image.png',
              width: double.infinity,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ChooseSignUp.CHOOSE_SIGN_UP);
            },
            child: SlideTransition(
              position: _animation,
              child: Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                    color: Color(0xff4A4E69), shape: BoxShape.circle),
                child: Icon(
                  Icons.chevron_right_sharp,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
