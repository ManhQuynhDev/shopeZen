import 'package:shop_zen/data/database/db_helper.dart';
import 'package:shop_zen/data/models/order.dart';

class OrderDao {
  DbHelper dbHelper = DbHelper();

  Future<bool> insertOrder(Order order) async {
    final db = await dbHelper.initDb(); //Khởi tạo db

    int result = await db.rawInsert('''
                  INSERT INTO Orders (userId , orderItemId , addressId ,totalPrice , time , status)
                  VALUES (? , ? , ? , ? , ? ,?)
                  ''', [
      order.userId,
      order.orderItemId,
      order.addressId,
      order.totalPrice,
      order.time,
      order.status
    ]);
    return result != 0;
  }

  Future<List<Order>> getAllListData(int userId) async {
    final db = await dbHelper.initDb();
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM Orders WHERE userId = ?',[userId]);

    List<Order> orders = result.map((o) {
      return Order(
        id: o['id'],
        userId: o['userId'],
        orderItemId: o['orderItemId'],
        addressId: o['addressId'],
        totalPrice: o['totalPrice'],
        time: o['time'],
        status: o['status'],
      );
    }).toList();
    return orders;
  }
}
