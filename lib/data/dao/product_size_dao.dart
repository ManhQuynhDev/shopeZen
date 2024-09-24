import 'package:shop_zen/data/database/db_helper.dart';
import 'package:shop_zen/data/models/product_size.dart';

class ProductSizeDao {
  late var db;
  DbHelper dbHelper = DbHelper();

  ProductSizeDao() {
    db = dbHelper.initDb();
  }

  Future<bool> insertSize(ProductSize size) async {
    int result = await db.rawInsert('''
                  INSERT INTO ProductSizes (productId , size)
                  VALUES (? , ?)
                  ''', [size.productId, size.size]);

    return result != 0;
  }

  Future<bool> updateSize(int id, ProductSize size) async {
    int result = await db.rawUpdate('''
                  UPDATE ProductSizes 
                  SET size = ?
                  WHERE id = ?
                  ''', [size.size, id]);

    return result != 0;
  }

  Future<bool> deleteSize(int id) async {
    int result = await db.rawUpdate('''
                  DELETE FROM ProductSizes WHERE id = ?
                  ''', [id]);

    return result != 0;
  }

  Future<List<ProductSize>> getAllListData(int productId) async {
    final db = await dbHelper.initDb();
    final List<Map<String, dynamic>> result = await db
        .rawQuery('SELECT * FROM ProductSizes WHERE productId = ?', [productId]);

    List<ProductSize> sizes = result.map((s) {
      return ProductSize(
        id: s['id'],
        productId: s['productId'],
        size: s['size'],
      );
    }).toList();
    return sizes;
  }
}
