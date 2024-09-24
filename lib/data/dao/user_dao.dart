import 'package:shop_zen/data/database/db_helper.dart';
import 'package:shop_zen/data/models/user.dart';

class UserDao {
  DbHelper dbHelper = DbHelper();

  Future<bool> registerUser(User user) async {
    final db = await dbHelper.initDb(); //Khởi tạo db

    //C1

    // await db.insert('Users', user.toMap(),
    //     conflictAlgorithm:
    //         ConflictAlgorithm.replace); //replace if conflict data

    //C2

    int result = await db.rawInsert('''
                          INSERT INTO Users (username, password, email)
                          VALUES (?, ?, ?)
                      ''', [user.username, user.password, user.email]);

    return result != 0;
  }

  Future<bool> checkLogin(String username, String password) async {
    final db = await dbHelper.initDb(); //Khởi tạo db
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT * FROM Users WHERE username = ? AND password = ?',
      [username, password],
    );

    return result.isNotEmpty;
  }

  Future<User?> findAnUser(String username) async {
    final db = await dbHelper.initDb(); //Khởi tạo db
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT * FROM Users WHERE username = ?',
      [username],
    );
    if (result.isNotEmpty) {
      final u = result.first;
      return User(
          id: u['id'],
          username: u['username'],
          password: u['password'],
          email: u['email']);
    } else {
      return null;
    }
  }

  Future<User?> findAnUserById(int id) async {
    final db = await dbHelper.initDb(); //Khởi tạo db
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT * FROM Users WHERE id = ?',
      [id],
    );
    if (result.isNotEmpty) {
      final u = result.first;
      return User(
          id: u['id'],
          username: u['username'],
          password: u['password'],
          email: u['email']);
    } else {
      return null;
    }
  }
}
