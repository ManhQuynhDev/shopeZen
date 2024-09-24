import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/product_dao.dart';
import 'package:shop_zen/data/models/order_item.dart';
import 'package:shop_zen/data/models/product.dart';

class ItemOrder extends StatefulWidget {
  const ItemOrder({
    super.key,
    required this.orderItem,
  });

  final OrderItem orderItem;

  @override
  State<ItemOrder> createState() => _ItemOrderState();
}

class _ItemOrderState extends State<ItemOrder> {
  Product? product;
  ProductDao productDao = ProductDao();

  Future<void> _loadProductData() async {
    try {
      // Lấy thông tin sản phẩm dựa trên cartId
      Product? fetchedProduct =
          await productDao.getAnProduct(widget.orderItem.productId);
      setState(() {
        product = fetchedProduct;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
        )
      ], borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              width: 100,
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: 'assets/images/loading_icon.png',
              image: product?.imageUrl ??
                  'https://images2.thanhnien.vn/528068263637045248/2024/1/25/e093e9cfc9027d6a142358d24d2ee350-65a11ac2af785880-17061562929701875684912.jpg',
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  '${product?.name}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$${product?.price}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(TextSpan(text: 'Size : ', children: [
                        TextSpan(text: '${widget.orderItem.size}')
                      ])),
                      Text.rich(TextSpan(text: 'Quantiy : ', children: [
                        TextSpan(text: '${widget.orderItem.quantity}')
                      ])),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
