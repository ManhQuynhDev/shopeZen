import 'package:flutter/material.dart';

class FinishScreen extends StatelessWidget {
  const FinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                width: double.infinity,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  child: const Icon(Icons.chevron_left_outlined),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: size.height * 0.6,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/finish.png"),
                        fit: BoxFit
                            .contain,
                        
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/undraw_order.png',
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Order Confirmed!',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 10),
                        Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14 , fontWeight: FontWeight.w500,
                              color: Colors.grey
                            ),
                            'Your order has been confirmed, we will send you confirmation email shortly.')
                      ],
                    ),
                  )),
              SizedBox(
                height: size.height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(size.width * 0.9, 48),
                            backgroundColor: Color(0xffF5F5F5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child: const Text(
                          'Go to Orders',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(size.width * 0.9, 48),
                            backgroundColor: Color(0xff4A4E69),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child: const Text(
                          'Continue Shopping',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
