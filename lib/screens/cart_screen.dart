import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/cart_dao.dart';
import 'package:shop_zen/data/dao/product_dao.dart';
import 'package:shop_zen/data/models/cart.dart';
import 'package:shop_zen/data/models/product.dart';
import 'package:shop_zen/screens/payment_screen.dart';
import 'package:shop_zen/screens/widget/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartDao cartDao = CartDao();
  List<bool> _checked = [];
  List<Cart> listCart = [];
  double totalPrice = 0;
  ProductDao productDao = ProductDao();

  Future<void> loadData() async {
    List<Cart> list = await cartDao.getAllListData();
    setState(() {
      listCart = list;
      _checked = List.generate(list.length, (index) => false); // Khởi tạo danh sách checkbox
    });
    totalPrices(); // Gọi hàm tính tổng giá trị
  }

  Future<void> totalPrices() async {
    double total = 0; // Khởi tạo biến tổng giá trị
    for (var c in listCart) {
      Product? product = await productDao.getAnProduct(c.productId);
      if (product != null) {
        total += product.price; // Cộng dồn giá trị sản phẩm vào tổng
      }
    }
    setState(() {
      totalPrice = total; // Cập nhật tổng giá trị vào totalPrice
    });
  }

  @override
  void initState() {
    super.initState();
    loadData(); // Gọi hàm loadData
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Cart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: size.height * 0.71,
              child: ListView.builder(
                itemCount: listCart.length,
                itemBuilder: (context, index) {
                  Cart cart = listCart[index];
                  return CartItemWidget(
                    cart: listCart[index],
                    isChecked: _checked[index],
                    onCheckedChanged: (value) {
                      setState(() {
                        _checked[index] = value!;
                      });
                    },
                    loadData: loadData,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: size.width,
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Choose All',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Checkbox(value: false, onChanged: (value) {})
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Total : $totalPrice',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen()));
                          },
                          child: Text('Check out now'))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
