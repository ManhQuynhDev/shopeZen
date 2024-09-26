import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_zen/data/dao/favorite_dao.dart';
import 'package:shop_zen/data/dao/user_dao.dart';
import 'package:shop_zen/data/models/favorite.dart';
import 'package:shop_zen/data/models/product.dart';
import 'package:shop_zen/data/models/user.dart';
import 'package:shop_zen/screens/details_screen.dart';
import 'package:shop_zen/screens/widget/show_message_widget.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  String userToken = '';
  int userId = 0;

  UserDao userDao = UserDao();
  FavoriteDao favoriteDao = FavoriteDao();

  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(key);

    if (token != null && token.isNotEmpty) {
      return token;
    }
    return null;
  }

  Future<void> getUserId(Function fetchData) async {
    String? token =
        await fetchData('userToken'); // Sử dụng `fetchData` thay vì `getData`

    if (token != null) {
      User? user = await userDao.findAnUser(token);
      if (user != null && user.id != 0) {
        setState(() {
          userId = user.id;
        });
      }
    } else {
      print("Token not found or invalid.");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserId(getData);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(product: widget.product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
        height: 200,
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
                        placeholder:
                            AssetImage('assets/images/loading_icon.png'),
                        image: NetworkImage(widget.product.imageUrl ?? ''),
                        fit: BoxFit.contain,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/loading_icon.png',
                              fit: BoxFit.contain);
                        },
                      ),
                    ),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () async {
                            Favorite favorite = Favorite(
                                id: 0,
                                productId: widget.product.id,
                                userId: userId);
                            bool isExit = await favoriteDao.isCheckExit(
                                widget.product.id, userId);
                            if (isExit) {
                              bool isSucess =
                                  await favoriteDao.insertFavorite(favorite);
                              isSucess
                                  ? showMessage(
                                      context, 'Add favorite sucessfully')
                                  : showMessage(
                                      context, 'Add favorite not sucessfully');
                            } else {
                              showMessage(context, 'Record already exists');
                            }
                          },
                          icon: Icon(Icons.favorite),
                          color: Colors.white,
                        ))
                  ],
                )),
            Expanded(
              flex: 25,
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      widget.product.name,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Text(
                      '\$${widget.product.price}',
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
      ),
    );
  }
}
