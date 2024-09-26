import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/product_dao.dart';
import 'package:shop_zen/data/models/category.dart';
import 'package:shop_zen/data/models/product.dart';
import 'package:shop_zen/screens/widget/empty_list_widget.dart';
import 'package:shop_zen/screens/widget/product_item.dart';

class ProductByIdScreen extends StatefulWidget {
  final Category category;
  const ProductByIdScreen({super.key, required this.category});

  @override
  State<ProductByIdScreen> createState() => _ProductByIdScreenState();
}

class _ProductByIdScreenState extends State<ProductByIdScreen> {
  List<Product> listProduct = [];
  ProductDao productDao = ProductDao();
  Future<void> loadDataProduct(int category_id) async {
    List<Product> list =
        await productDao.getFindProductByCategoryId(category_id);
    setState(() {
      listProduct = list;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDataProduct(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Product By Category ${widget.category.name}',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(8.0),
          width: double.infinity,
          height: size.height * 0.9,
          child: listProduct.length == 0
              ? EmptyListWidget(message: 'Category',)
              : GridView.builder(
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
    );
  }
}
