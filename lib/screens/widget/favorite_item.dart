import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/product_dao.dart';
import 'package:shop_zen/data/models/favorite.dart';
import 'package:shop_zen/data/models/product.dart';

class FavoriteItem extends StatefulWidget {
  final Favorite favorite;
  const FavoriteItem({super.key, required this.favorite});

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  ProductDao productDao = ProductDao();
  Product? product;

  Future<void> getAnProduct(int productId) async {
    Product? foundProduct = await productDao.getAnProduct(productId);
    setState(() {
      product = foundProduct;
    });
  }

  @override
  void initState() {
    super.initState();
    getAnProduct(widget.favorite.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
      height: 175,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 75,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage(
                      placeholder: AssetImage(
                          'assets/images/loading_icon.png'), // Sử dụng AssetImage cho hình ảnh tạm thời
                      image: NetworkImage(product?.imageUrl ??
                          ''), // Sử dụng NetworkImage cho ảnh từ mạng
                      fit: BoxFit.contain,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/loading_icon.png',
                            fit: BoxFit
                                .contain); // Hiển thị ảnh tạm nếu tải ảnh từ mạng thất bại
                      },
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ))
                ],
              )),
          Expanded(
            flex: 25,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    product?.name ?? 'Loading',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Text(
                    '\$${product?.price ?? 'Loading'}',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
