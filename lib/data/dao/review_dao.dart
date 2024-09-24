import 'package:shop_zen/data/database/db_helper.dart';
import 'package:shop_zen/data/models/review.dart';

class ReviewDao {
  DbHelper dbHelper = DbHelper();

  Future<bool> insertReview(Review review) async {
    final db = await dbHelper.initDb(); //Khởi tạo db

    int result = await db.rawInsert('''
                  INSERT INTO ReViews (productId , userId ,title , content, star , time)
                  VALUES (? , ? , ? , ? , ? , ?)
                  ''', [
      review.productId,
      review.userId,
      review.title,
      review.content,
      review.star,
      review.time
    ]);

    return result != 0;
  }

  Future<List<Review>> getAllListData(int productId) async {
    final db = await dbHelper.initDb(); //Khởi tạo db
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM ReViews WHERE productId = ?', [productId]);
    List<Review> reviews = result.map((record) {
      return Review(
          id: record['id'],
          productId: record['productId'],
          userId: record['userId'],
          title: record['title'],
          content: record['content'],
          star: record['star'],
          time: record['time']);
    }).toList();
    return reviews;
  }
}
