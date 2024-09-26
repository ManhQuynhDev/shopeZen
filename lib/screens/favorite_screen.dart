import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/favorite_dao.dart';
import 'package:shop_zen/data/dao/product_dao.dart';
import 'package:shop_zen/data/models/favorite.dart';
import 'package:shop_zen/data/models/product.dart';
import 'package:shop_zen/screens/widget/empty_list_widget.dart';
import 'package:shop_zen/screens/widget/favorite_item.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Favorite> list = [];
  FavoriteDao favoriteDao = FavoriteDao();

  Future<void> loadData() async {
    List<Favorite> listFavorite = await favoriteDao.getAllListData();
    setState(() {
      list = listFavorite;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            actions: [
              Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: Icon(Icons.shopping_bag)),
            ],
            title: Center(
                child: Text(
              'Wishlist',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )),
            leading: Icon(Icons.arrow_back)),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12.0),
          child: list.length == 0
              ? SizedBox(
                  width: double.infinity,
                  height: size.height * 0.8,
                  child: EmptyListWidget(message:  'Favorite'),
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${list.length} Items',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'in wishlist',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            )
                          ],
                        ),
                        Container(
                          width: 68,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.mode_edit_rounded,
                                size: 20,
                              ),
                              Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: size.height * 0.72,
                        child: GridView.builder(
                          itemCount: list.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: size.width > 500 ? 3 : 2,
                                  crossAxisSpacing: 15.0,
                                  childAspectRatio: 0.8 / 1.3),
                          itemBuilder: (BuildContext context, int index) {
                            Favorite favorite = list[index];
                            return FavoriteItem(
                                favorite: favorite, loadData: loadData);
                          },
                        )),
                  ],
                ),
        ),
      ),
    );
  }
}
