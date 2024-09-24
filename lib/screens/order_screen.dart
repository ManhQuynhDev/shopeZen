import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_zen/data/dao/order_dao.dart';
import 'package:shop_zen/data/dao/order_item_dao.dart';
import 'package:shop_zen/data/dao/user_dao.dart';
import 'package:shop_zen/data/models/order.dart';
import 'package:shop_zen/data/models/order_item.dart';
import 'package:shop_zen/data/models/user.dart';
import 'package:shop_zen/screens/widget/order_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  UserDao userDao = UserDao();

  int userId = 0;

  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(key);

    if (token != null && token.isNotEmpty) {
      print('Token: $token');
      return token;
    } else {
      print('Token is null or empty');
      return null;
    }
  }

  OrderItemDao orderItemDao = OrderItemDao();

  List<OrderItem> listOrderItem = [];

  Future<void> findOrderItem(int orderItemId) async {
    List<OrderItem> list = await orderItemDao.getAllListData(orderItemId);
    setState(() {
      listOrderItem = list;
    });
  }

  Future<void> foundUser(String key) async {
    String? username = await getData(key); // Sử dụng await để lấy giá trị
    if (username != null) {
      User? user = await userDao.findAnUser(username);
      if (user != null) {
        setState(() {
          userId = user.id;
        });
        print(userId);
      } else {
        print('User not found');
      }
    } else {
      print('Username is null');
    }
  }

  OrderDao orderDao = OrderDao();
  List<Order> listOrder = [];
  Future<void> loadData() async {
    await foundUser('userToken');
    List<Order> list = await orderDao.getAllListData(userId);
    setState(() {
      listOrder = list;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Your order',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: double.infinity,
              height: size.height * 0.8,
              child: ListView.builder(
                itemCount: listOrder.length,
                itemBuilder: (context, index) {
                  Order order = listOrder[index];
                  findOrderItem(order.orderItemId);
                  return Card(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      height: size.height * 0.25,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order Id : ${order.id}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '${order.time.substring(0, 16)}',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total: \$${order.totalPrice}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text.rich(TextSpan(
                                  text: 'Status : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                        text: 'PENDING',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500))
                                  ])),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Expanded(
                              child: ListView.builder(
                            itemCount: listOrderItem.length,
                            itemBuilder: (context, index) {
                              OrderItem orderItem = listOrderItem[index];
                              return Card(
                                  child: ItemOrder(orderItem: orderItem));
                            },
                          ))
                        ],
                      ),
                    ),
                  );
                },
              )),
        ));
  }
}
