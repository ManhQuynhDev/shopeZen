import 'dart:math';

class Category {
  int id = 0;
  String name;
  String logo;

  Category({required this.name, required this.logo}) {
    id = Random().nextInt(100);
  }
}
