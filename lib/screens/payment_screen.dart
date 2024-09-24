import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/address_dao.dart';
import 'package:shop_zen/data/dao/cart_dao.dart';
import 'package:shop_zen/data/dao/order_dao.dart';
import 'package:shop_zen/data/dao/order_item_dao.dart';
import 'package:shop_zen/data/dao/product_dao.dart';
import 'package:shop_zen/data/models/address.dart';
import 'package:shop_zen/data/models/cart.dart';
import 'package:shop_zen/data/models/order.dart';
import 'package:shop_zen/data/models/order_item.dart';
import 'package:shop_zen/data/models/product.dart';
import 'package:shop_zen/screens/add_address_screen.dart';
import 'package:shop_zen/screens/finish_screen.dart';
import 'package:shop_zen/screens/widget/cart_item_widget.dart';
import 'package:shop_zen/screens/widget/show_message_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CartDao cartDao = CartDao();
  AddressDao addressDao = AddressDao();
  List<Address> listAddress = [];
  List<bool> _checked = [];
  List<Cart> listCart = [];
  ProductDao productDao = ProductDao();

  OrderDao orderDao = OrderDao();
  OrderItemDao orderItemDao = OrderItemDao();

  double totalPrice = 0;

  Future<void> totalPrices() async {
    double total = 0;
    for (var c in listCart) {
      Product? product = await productDao.getAnProduct(c.productId);
      if (product != null) {
        total += product.price;
      }
    }
    setState(() {
      totalPrice = total;
    });
  }

  Future<void> loadData() async {
    List<Cart> getListData = await cartDao.getAllListData();
    List<Address> getListAddress = await addressDao.getAllListData();
    setState(() {
      listCart = getListData;
      listAddress = getListAddress;
      _checked = List.generate(getListData.length, (index) => false);
    });
    totalPrices();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Check out',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              height: size.height * 0.35,
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery Address',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddAddressScreen()));
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/map.png',
                  width: 60,
                  height: 60,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        listAddress.isNotEmpty
                            ? Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                '${listAddress[0].country}, ${listAddress[0].city}, ${listAddress[0].address}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              )
                            : Text('No address available'),
                        listAddress.isNotEmpty
                            ? Text(
                                '${listAddress[0].name}',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              )
                            : Text('No available'),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Color(0xff4A4E69),
                      border: Border.all(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Icon(
                    Icons.done,
                    size: 17,
                    color: Colors.white,
                  )),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/map.png',
                  width: 60,
                  height: 60,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Visa Classic',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '**** 7690',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Color(0xff4A4E69),
                      border: Border.all(width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Icon(
                    Icons.done,
                    size: 17,
                    color: Colors.white,
                  )),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Order Info',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\$${totalPrice}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping cost',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\$10',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\$${totalPrice + 10}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: () async {
                  //clear data trong card
                  for (var c in listCart) {
                    OrderItem orderItem = OrderItem(
                        id: 0,
                        productId: c.productId,
                        userId: c.userId,
                        quantity: c.quantity,
                        size: c.size);
                    bool isSusess =
                        await orderItemDao.insertOrderItem(orderItem);
                    if (isSusess) {
                      Order order = Order(
                          id: 0,
                          userId: c.userId,
                          addressId: listAddress[0].id,
                          orderItemId: orderItem.id,
                          totalPrice: totalPrice,
                          time: DateTime.now().toString(),
                          status: ORDER_STATUS.PENDING_CONFIRMATION.toString());
                      bool isSusess = await orderDao.insertOrder(order);
                      if (isSusess) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FinishScreen()));
                        await cartDao.deleteCart(c.id);
                      } else {
                        showMessage(context, 'Problem creating order');
                      }
                    } else {
                      showMessage(context, 'Problem creating order item');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 0.9, 48),
                    backgroundColor: Color(0xff4A4E69),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                child: const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
          ],
        ),
      ),
    ));
  }
}
