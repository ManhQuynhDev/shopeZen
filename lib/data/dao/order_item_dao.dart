import 'package:shop_zen/data/database/db_helper.dart';
import 'package:shop_zen/data/models/order_item.dart';

class OrderItemDao {
  DbHelper dbHelper = DbHelper();

  Future<bool> insertOrderItem(OrderItem orderItem) async {
    final db = await dbHelper.initDb(); //Khởi tạo db

    int result = await db.rawInsert('''
                  INSERT INTO OrderItem (productId , userId , quantity , size)
                  VALUES (? , ? , ? , ?)
                  ''', [
      orderItem.productId,
      orderItem.userId,
      orderItem.quantity,
      orderItem.size
    ]);

    return result != 0;
  }

  Future<OrderItem?> getAnOrderItem(int id) async {
    final db = await dbHelper.initDb(); //Khởi tạo db
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM OrderItem WHERE id = ?', [id]);

    if (result.isNotEmpty) {
      var record = result.first;
      return OrderItem(
          id: record['id'],
          productId: record['productId'],
          userId: record['userId'],
          quantity: record['quantity'],
          size: record['size']);
    } else {
      return null;
    }
  }

  Future<List<OrderItem>> getAllListData(int id) async {
    final db = await dbHelper.initDb();
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM OrderItem');

    List<OrderItem> orderItems = result.map((record) {
      return OrderItem(
          id: record['id'],
          productId: record['productId'],
          userId: record['userId'],
          quantity: record['quantity'],
          size: record['size']);
    }).toList();
    return orderItems;
  }
}
