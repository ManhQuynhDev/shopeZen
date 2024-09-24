import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/cart_dao.dart';
import 'package:shop_zen/data/dao/product_dao.dart'; // Giả sử có ProductDao
import 'package:shop_zen/data/models/cart.dart';
import 'package:shop_zen/data/models/product.dart';
import 'package:shop_zen/screens/widget/show_message_widget.dart'; // Giả sử có model Product

class CartItemWidget extends StatefulWidget {
  final Cart cart;
  final bool isChecked;
  final ValueChanged<bool?> onCheckedChanged;
  final Function loadData;

  const CartItemWidget({
    Key? key,
    required this.cart,
    required this.isChecked,
    required this.onCheckedChanged,
    required this.loadData
  }) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  Product? product;
  bool isLoading = true;
  late int quantity;

  // Khởi tạo DAO (Data Access Object) để lấy dữ liệu product
  ProductDao productDao = ProductDao();
  CartDao cartDao = CartDao();

  @override
  void initState() {
    super.initState();
    _loadProductData();
    setState(() {
      quantity = widget.cart.quantity;
    });
  }

  Future<void> _loadProductData() async {
    try {
      // Lấy thông tin sản phẩm dựa trên cartId
      Product? fetchedProduct =
          await productDao.getAnProduct(widget.cart.productId);
      setState(() {
        product = fetchedProduct;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (product == null) {
      return Center(child: Text('Product not found'));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
        )
      ], borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use the checked state
          Checkbox(value: widget.isChecked, onChanged: widget.onCheckedChanged),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              width: 100,
              height: double.infinity,
              fit: BoxFit.contain,
              placeholder: 'assets/images/loading_icon.png',
              image: product!.imageUrl,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product!.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$${product!.price} (-\$4.00 Tax)',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  width: size.width * 0.3,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cart.size,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          } else {
                            showMessage(context, 'Quantity don\'t less 0');
                          }
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Text(
                            '-',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            quantity++;
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: const Text(
                            '+',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm'),
                      content: Text('Do you want to delele this cart ?'),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            bool isCheck =
                                await cartDao.deleteCart(widget.cart.id);
                            if (isCheck) {
                              Navigator.pop(context);
                              widget.loadData();
                            }
                          },
                          child: const Text('Ok'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  });
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                  child: Icon(
                Icons.delete_outline_outlined,
                size: 17,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
