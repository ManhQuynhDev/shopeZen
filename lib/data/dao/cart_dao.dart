import 'package:shop_zen/data/database/db_helper.dart';
import 'package:shop_zen/data/models/cart.dart';

class CartDao {
  DbHelper dbHelper = DbHelper();

  Future<bool> insertCart(Cart cart) async {
    final db = await dbHelper.initDb(); //Khởi tạo db

    int result = await db.rawInsert('''
                  INSERT INTO Carts (productId , size , quantity , userId)
                  VALUES (? , ? , ? , ?)
                  ''', [cart.productId, cart.size, cart.quantity, cart.userId]);

    return result != 0;
  }

  Future<bool> updateCart(int id, int quantity) async {
    final db = await dbHelper.initDb();

    int result = await db.rawUpdate('''
        UPDATE Carts
        SET quantity = ?
        WHERE id = ?
        ''', [quantity , id]);

    return result > 0;
  }

  Future<bool> deleteCart(int id) async {
    final db = await dbHelper.initDb();
    int result = await db.rawDelete('DELETE FROM Carts WHERE id = ?', [id]);
    return result != 0;
  }

  Future<List<Cart>> getAllListData() async {
    final db = await dbHelper.initDb();
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM Carts');

    List<Cart> carts = result.map((record) {
      return Cart(
        id: record['id'],
        productId: record['productId'],
        size: record['size'],
        quantity: record['quantity'],
        userId: record['userId'],
      );
    }).toList();
    return carts;
  }
}
