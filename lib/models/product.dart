import 'dart:math';

class Product {
  int id = 0;
  String name;
  double price;
  String urlImage;

  Product({required this.name, required this.price , required this.urlImage}) {
    id = Random().nextInt(100);
  }
}
