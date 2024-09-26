import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/category_dao.dart';
import 'package:shop_zen/data/dao/product_dao.dart';
import 'package:shop_zen/data/models/category.dart';
import 'package:shop_zen/data/models/product.dart';
import 'package:shop_zen/screens/cart_screen.dart';
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
  List<Product> listAllProduct = [];
  List<Product> listProduct = [];
  List<Product> listSearchProduct = [];
  List<Category> listCategory = [];
  TextEditingController _searchController = TextEditingController();

  int page_number = 1;
  int page_size = 4;
  bool isLoading = false;
  bool isSearch = false;

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    loadData();
    loadDataProduct();
    loadDataProduct();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        loadMoreProducts();
      }
    });
    _searchController.addListener(() {
      if (_searchController.text == '') {
        setState(() {
          isSearch = false;
          listSearchProduct.clear();
        });
      } else {
        setState(() {
          isSearch = true;
          listSearchProduct = listAllProduct
              .where((product) => product.name
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
              .toList();
        });
      }
    });
  }

  Future<void> loadData() async {
    List<Category> list = await categoryDao.getAllListData();
    setState(() {
      listCategory = list;
    });
  }

  Future<void> loadProductData() async {
    List<Product> list = await productDao.getAllListData();
    setState(() {
      listAllProduct = list;
    });
  }

  Future<void> loadDataProduct() async {
    setState(() {
      isLoading = true;
    });
    List<Product> list = await productDao.loadMore(
        page_number: page_number, page_size: page_size);
    setState(() {
      listProduct.addAll(list);
      isLoading = false;
    });
  }

  void loadMoreProducts() {
    setState(() {
      page_number++;
    });
    loadDataProduct();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  )),
              child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: Icon(Icons.shopping_bag)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      controller: _searchController,
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
                            child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
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
                  controller: isSearch
                      ? null
                      : _scrollController, // Đặt controller để cuộn
                  itemCount:
                      isSearch ? listSearchProduct.length : listProduct.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: size.width > 500 ? 3 : 2,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: 0.8 / 1.3),
                  itemBuilder: (BuildContext context, int index) {
                    Product product = listProduct[index];
                    return ProductItem(product: product);
                  },
                ),
              ),
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
