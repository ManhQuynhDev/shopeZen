import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;
  const EmptyListWidget({
    super.key, required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/cart.png',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          Text(
            'Cannot find product by ${message} !',
            style:
                TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          )
        ],
      );
  }
}
