import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff508082),
        body: Column(
          children: [
            Expanded(
                flex: 65,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: Image.asset('assets/images/image2.png'),
                )),
            Expanded(
                flex: 35,
                child: Container(
                  width: size.width,
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Look Good, Feel Good',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      const Text(
                          textAlign: TextAlign.center,
                          'Create your individual & unique style and look \namazing everyday.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                          ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(size.width * 0.35, 60),
                                  backgroundColor: const Color(0xff4A4E69),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6))),
                              child: const Text(
                                'Men',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(size.width * 0.35, 60),
                                  backgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6))),
                              child: const Text(
                                'Women',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              )),
                        ],
                      ),
                      const Text('Skip',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey
                      ),)
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
