import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/favorite_dao.dart';
import 'package:shop_zen/data/dao/product_dao.dart';
import 'package:shop_zen/data/models/favorite.dart';
import 'package:shop_zen/data/models/product.dart';
import 'package:shop_zen/screens/widget/show_message_widget.dart';

class FavoriteItem extends StatefulWidget {
  final Favorite favorite;
  final Function loadData;
  const FavoriteItem(
      {super.key, required this.favorite, required this.loadData});

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  ProductDao productDao = ProductDao();
  FavoriteDao favoriteDao = FavoriteDao();
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
                      placeholder: AssetImage('assets/images/loading_icon.png'),
                      image: NetworkImage(product?.imageUrl ?? ''),
                      fit: BoxFit.contain,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/loading_icon.png',
                            fit: BoxFit
                                .contain);
                      },
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm'),
                                  content:
                                      Text('Do you want to delele this item ?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        bool isCheck = await favoriteDao
                                            .deleteFavorite(widget.favorite.id);
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
