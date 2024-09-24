import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/category_dao.dart';
import 'package:shop_zen/data/dao/product_dao.dart';
import 'package:shop_zen/data/models/category.dart';
import 'package:shop_zen/data/models/product.dart';
import 'package:shop_zen/screens/details_screen.dart';
import 'package:shop_zen/screens/widget/category_item.dart';
import 'package:shop_zen/screens/widget/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryDao categoryDao = CategoryDao();
  ProductDao productDao = ProductDao();

  List<Product> listProduct = [];

  List<Category> listCategory = [];

  Future<void> loadData() async {
    // Tải dữ liệu từ cơ sở dữ liệu và cập nhật trạng thái
    List<Category> list = await categoryDao.getAllListData();
    setState(() {
      listCategory = list;
    });
  }

  Future<void> loadDataProduct() async {
    // Tải dữ liệu từ cơ sở dữ liệu và cập nhật trạng thái
    List<Product> list = await productDao.getAllListData();
    setState(() {
      listProduct = list;
    });
  }

  @override
  void initState() {
    loadData();
    loadDataProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(Icons.menu),
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
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //         width: 45,
              //         height: 45,
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Colors.grey.withOpacity(0.2)),
              //         child: Image.asset('assets/images/icon_menu.png')),
              //     Container(
              //         width: 45,
              //         height: 45,
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: Colors.grey.withOpacity(0.2)),
              //         child: Image.asset('assets/images/icon_bag.png'))
              //   ],
              // ),
              SizedBox(
                width: size.width * 0.3,
                child: RichText(
                  text: TextSpan(
                    text: 'Hello\n',
                    style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'Welcome to Laza.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.75,
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          labelText: 'Search',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff4A4E69),
                        ),
                        child: Center(
                            child: Icon(
                          Icons.mic,
                          color: Colors.white,
                        ))),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose Brand',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Text('View All',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey))
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listCategory.length,
                  itemBuilder: (context, index) {
                    Category category = listCategory[index];
                    return CategoryItem(category: category);
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Arraival',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Text('View All',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey))
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                  width: double.infinity,
                  height: size.height * 0.4,
                  child: GridView.builder(
                    itemCount: listProduct.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.width > 500 ? 3 : 2,
                        crossAxisSpacing: 15.0,
                        childAspectRatio: 0.8 / 1.3),
                    itemBuilder: (BuildContext context, int index) {
                      Product product = listProduct[index];
                      return ProductItem(product: product);
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
