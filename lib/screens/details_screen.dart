import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_zen/data/dao/cart_dao.dart';
import 'package:shop_zen/data/dao/category_dao.dart';
import 'package:shop_zen/data/dao/product_dao.dart';
import 'package:shop_zen/data/dao/product_size_dao.dart';
import 'package:shop_zen/data/dao/user_dao.dart';
import 'package:shop_zen/data/models/cart.dart';
import 'package:shop_zen/data/models/category.dart';
import 'package:shop_zen/data/models/product.dart';
import 'package:shop_zen/data/models/product_size.dart';
import 'package:shop_zen/data/models/user.dart';
import 'package:shop_zen/screens/reviews_screen.dart';
import 'package:shop_zen/screens/widget/show_message_widget.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({super.key, required this.product});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  CategoryDao categoryDao = CategoryDao();
  ProductSizeDao productSizeDao = ProductSizeDao();
  UserDao userDao = UserDao();
  CartDao cartDao = CartDao();

  Category? category;

  Future<void> foundCategory() async {
    Category? foundCategory =
        await categoryDao.getAnCategory(widget.product.categoryId);
    if (foundCategory != null) {
      setState(() {
        category = foundCategory;
      });
    } else {
      print('null');
    }
  }

  String userToken = '';

  Future<void> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(key);

    if (token != null && token.isNotEmpty) {
      setState(() {
        userToken = token;
      });
    }
  }

  List<ProductSize> sizes = [];

  Future<void> foundSize() async {
    List<ProductSize> foundProductSize =
        await productSizeDao.getAllListData(widget.product.id);
    if (foundProductSize.isNotEmpty) {
      setState(() {
        sizes = foundProductSize;
        choose = sizes.first;
      });
    } else {
      print('No sizes found');
    }
  }

  Future<User?> foundUser(String username) async {
    User? user = await userDao.findAnUser(username);
    return user;
  }

  late ProductSize choose;

  @override
  void initState() {
    super.initState();
    foundSize();
    foundCategory();
    getData('userToken');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.45,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: NetworkImage(widget.product.imageUrl))),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Icon(Icons.arrow_back)),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Image.asset('assets/images/icon_bag.png'))
                        ],
                      ),
                      Positioned(
                        right: size.width * 0.4,
                        bottom: 0,
                        child: Container(
                          width: 80,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: Center(
                              child: Text(
                            category?.name ?? 'Unknown',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product Name',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          Text(
                            'Price',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name.length > 25
                                ? widget.product.name.substring(0, 25) + '...'
                                : widget.product.name,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            '\$ ${widget.product.price}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.1,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              width: size.width * 0.24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10), // Bo góc cho viền (nếu cần)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    10), // Bo góc cho ảnh (khớp với viền)
                                child: Image.network(
                                  widget.product
                                      .imageUrl, // URL hoặc đường dẫn hình ảnh
                                  fit: BoxFit
                                      .cover, // Để hình ảnh vừa khít với Container
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Size',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          Text('Size Guide',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: sizes.map((s) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                choose = s;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10)),
                              width: size.width * 0.15,
                              height: size.width * 0.15,
                              child: Center(
                                  child: Text(
                                s.size,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: choose == s
                                        ? Colors.black
                                        : Colors.grey),
                              )),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.start,
                        widget.product.description,
                        softWrap: true,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reviews',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewsScreen(
                                        productId: widget.product.id,
                                        userToken: userToken),
                                  ));
                            },
                            child: Text('View All',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue)),
                          )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: size.height * 0.18,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ronald Richards',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        RichText(
                                            text: TextSpan(children: [
                                          WidgetSpan(
                                              child: Icon(
                                            Icons.timer,
                                            size: 18,
                                            color: Colors.grey.withOpacity(0.7),
                                          )),
                                          TextSpan(
                                              text: ' 13 Sep, 2020',
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.7)))
                                        ]))
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                        text: const TextSpan(
                                            text: '4.8',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                            children: [
                                          TextSpan(
                                            text: ' rating',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          )
                                        ])),
                                    SizedBox(height: 5),
                                    Row(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          size: 15,
                                          index < 4
                                              ? Icons.star
                                              : Icons
                                                  .star_border, // Hiển thị sao đầy hoặc sao trống
                                          color: Colors.amber,
                                        );
                                      }),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const Text(
                              maxLines: 3,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              'Lorem ipsum dolor sit amet take care of me , i dont like you,when you go to viris consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Total Price',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'with VAT,SD',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              )
                            ],
                          ),
                          Text(
                            '\$${widget.product.price + 20}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: size.width * 0.8,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              backgroundColor: Color(0xff4A4E69),
                            ),
                            onPressed: () async {
                              User user = await foundUser(userToken) as User;
                              Cart cart = Cart(
                                  id: 0,
                                  productId: widget.product.id,
                                  size: choose.size,
                                  quantity: 1,
                                  userId: user.id);
                              bool isSucess = await cartDao.insertCart(cart);
                              if (isSucess) {
                                showMessage(context, "Add successfully");
                              } else {
                                showMessage(context, "Failed to add");
                              }
                            },
                            child: Text(
                              'Add to cart',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
