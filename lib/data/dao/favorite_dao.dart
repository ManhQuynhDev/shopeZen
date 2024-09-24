import 'package:shop_zen/data/database/db_helper.dart';
import 'package:shop_zen/data/models/favorite.dart';

class FavoriteDao {
  DbHelper dbHelper = DbHelper();

  Future<bool> insertFavorite(Favorite favorite) async {
    final db = await dbHelper.initDb(); //Khởi tạo db

    int result = await db.rawInsert('''
                  INSERT INTO Favorites (productId , userId)
                  VALUES (? , ?)
                  ''', [favorite.productId, favorite.userId]);

    return result != 0;
  }

  Future<bool> updateFavorite(int id, Favorite favorite) async {
    final db = await dbHelper.initDb(); //Khởi tạo db

    int result = await db.rawUpdate('''
                  UPDATE Favorites
                  SET productId = ? , userID = ?
                  WHERE id = ?
                  ''', [favorite.productId, favorite.userId, id]);

    return result != 0;
  }

  Future<bool> deleteFavorite(int id) async {
    final db = await dbHelper.initDb(); //Khởi tạo db
    int result = await db.rawDelete('DELETE FROM Favorites WHERE id = ?', [id]);
    return result != 0;
  }

  Future<List<Favorite>> getAllListData() async {
    final db = await dbHelper.initDb(); //Khởi tạo db
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM Favorites');
    List<Favorite> favorites = result.map((record) {
      return Favorite(
        id: record['id'],
        productId: record['productId'],
        userId: record['userId'],
      );
    }).toList();
    return favorites;
  }

  Future<bool> isCheckExit(int productId, int userId) async {
    final db = await dbHelper.initDb(); //Khởi tạo db
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM Favorites WHERE productId = ? AND userId = ?',[productId , userId]);

    return result.isEmpty; //empty true ||  not empty false
  }
}
