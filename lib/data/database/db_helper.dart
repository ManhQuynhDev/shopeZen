import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Future<Database> initDb() async {
    // Lấy đường dẫn tới thư mục lưu trữ database
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'oct_l1.db');

    // Mở cơ sở dữ liệu và tạo bảng nếu nó chưa tồn tại
    return openDatabase(
      path,
      onCreate: (db, version) async {
        // Tạo bảng Users
        await db.execute(
          '''CREATE TABLE Users(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              username TEXT NOT NULL, 
              password TEXT NOT NULL, 
              email TEXT NOT NULL
          )''',
        );

        // Tạo bảng Categorys
        await db.execute('''CREATE TABLE Categorys(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            logo TEXT NOT NULL
        )''');

        // Tạo bảng Products
        await db.execute('''CREATE TABLE Products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            imageUrl TEXT NOT NULL,
            price DOUBLE NOT NULL,
            description TEXT NOT NULL,
            categoryId INTEGER NOT NULL,
            FOREIGN KEY (categoryId) REFERENCES Categorys(id)
        )''');

        // Tạo bảng ProductSizes
        await db.execute('''CREATE TABLE ProductSizes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER NOT NULL,
            size TEXT NOT NULL,
            FOREIGN KEY (productId) REFERENCES Products(id)
        )''');

        //Tạo bảng Cart
        await db.execute(''' CREATE TABLE Carts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER NOT NULL,
            size TEXT NOT NULL,
            quantity INTEGER NOT NULL,
            userId INTEGER NOT NULL,
            FOREIGN KEY (productId) REFERENCES Products(id),
            FOREIGN KEY (userId) REFERENCES Users(id)
        )''');

        //Favorite
        await db.execute('''CREATE TABLE Favorites(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER NOT NULL,
            userId INTEGER NOT NULL,
            FOREIGN KEY (productId) REFERENCES Products(id),
            FOREIGN KEY (userId) REFERENCES Users(id)
        )''');

        await db.execute('''CREATE TABLE ReViews(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER NOT NULL,
            userId INTEGER NOT NULL,
            star DOUBLE NOT NULL,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            time TEXT NOT NULL,
            FOREIGN KEY (productId) REFERENCES Products(id),
            FOREIGN KEY (userId) REFERENCES Users(id)
        )''');

        await db.execute('''CREATE TABLE Address(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER NOT NULL,
            name TEXT NOT NULL,
            country TEXT NOT NULL,
            city TEXT NOT NULL,
            phoneNumber TEXT NOT NULL,
            address TEXT NOT NULL,
            FOREIGN KEY (userId) REFERENCES Users(id)
        )''');

        await db.execute('''CREATE TABLE Orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER NOT NULL,
            orderItemId INTEGER NOT NULL,
            addressId INTEGER NOT NULL,
            totalPrice DOUBLE NOT NULL,
            time TEXT NOT NULL,
            status TEXT NOT NULL,
            FOREIGN KEY (userId) REFERENCES Users(id),
            FOREIGN KEY (orderItemId) REFERENCES OrderItem(id),
            FOREIGN KEY (addressId) REFERENCES Address(id)
        )''');

        await db.execute('''CREATE TABLE OrderItem(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            productId INTEGER NOT NULL,
            userId INTEGER NOT NULL,
            quantity INTEGER NOT NULL,
            size TEXT NOT NULL,
            FOREIGN KEY (productId) REFERENCES Products(id),
            FOREIGN KEY (userId) REFERENCES Users(id)
        )''');

        await db.insert('Users', {
          'username': 'admin',
          'password': 'admin123',
          'email': 'admin@example.com',
        });

        await db.insert('Categorys', {
          'name': 'Clothing',
          'logo':
              'https://wego.net.vn/wp-content/uploads/2021/10/ao-khoac-dong-phuc-ak0029.jpg',
        });
        await db.insert('Categorys', {
          'name': 'Shoes',
          'logo':
              'https://bizweb.dktcdn.net/thumb/1024x1024/100/336/177/products/1-18.jpg?v=1716367478560',
        });
        await db.insert('Categorys', {
          'name': 'Accessories',
          'logo':
              'https://ounass-ae.atgcdn.ae/contentful/b3xlytuyfm3e/4CEnplsFhY1u2DXk4qP7gK/d4cb5fcd039105581fbf78bb0386a52c/Women_Accessories_APP_PLP_Banner_copy.jpg?q=70',
        });

        await db.insert('Products', {
          'name': 'Áo thun phong cách màu hồng',
          'imageUrl':
              'https://wego.net.vn/wp-content/uploads/2024/03/ao-thun-phong-dong-phuc-spring-blooming-8-1.jpg',
          'price': 99.99,
          'description': 'Comfortable fleece sweatshirt for everyday use.',
          'categoryId': 1,
        });
        await db.insert('Products', {
          'name': 'Áo thun đồng phục',
          'imageUrl':
              'https://wego.net.vn/wp-content/uploads/2024/03/ao-thun-phong-dong-phuc-spring-blooming-2-1.jpg',
          'price': 120.00,
          'description': 'Classic Adidas shoes with a timeless design.',
          'categoryId': 2,
        });

        await db.insert('Products', {
          'name': 'Áo khoác đồng phục AK0029',
          'imageUrl':
              'https://wego.net.vn/wp-content/uploads/2021/10/ao-khoac-dong-phuc-ak0029.jpg',
          'price': 120.00,
          'description': 'Classic Adidas shoes with a timeless design.',
          'categoryId': 1,
        });

        await db.insert('Products', {
          'name': 'Giày thể thao cho giới trẻ',
          'imageUrl':
              'https://bizweb.dktcdn.net/thumb/1024x1024/100/336/177/products/1-18.jpg?v=1716367478560',
          'price': 20.00,
          'description': 'Classic Adidas shoes with a timeless design.',
          'categoryId': 2,
        });

        await db.insert('Products', {
          'name': 'Giày sport Adidas',
          'imageUrl':
              'https://bizweb.dktcdn.net/thumb/1024x1024/100/336/177/products/1-18.jpg?v=1716367478560',
          'price': 200.00,
          'description': 'Classic Adidas shoes with a timeless design.',
          'categoryId': 2,
        });

        await db.insert('Products', {
          'name': 'Áo khoác đồng phục AK123456',
          'imageUrl':
              'https://htmediagroup.vn/wp-content/uploads/2021/12/Ao-thun-11-min.jpg',
          'price': 120.00,
          'description': 'Đồng phục cao cấp chất liệu thoáng mát.',
          'categoryId': 1,
        });

        await db.insert('Products', {
          'name': 'Mũ len mùa đông',
          'imageUrl':
              'https://pos.nvncdn.com/cba2a3-7534/ps/20220414_E4OH2i6ERdQ1o4BDifAZtkMw.JPG',
          'price': 50.00,
          'description': 'Mũ len thời trang cho mùa đông.',
          'categoryId': 3,
        });

        await db.insert('Products', {
          'name': 'Áo thun nam Nike',
          'imageUrl':
              'https://s.alicdn.com/@sc04/kf/HTB1eyzQajDuK1RjSszdq6xGLpXaQ.jpg_720x720q50.jpg',
          'price': 180.00,
          'description': 'Áo thun Nike, phong cách thể thao.',
          'categoryId': 2,
        });

        await db.insert('Products', {
          'name': 'Quần thể thao Puma',
          'imageUrl':
              'https://antien.vn/files/styles/pslide/public/products/photos/2024/06/10/quan-ngan-the-thao-nike-CZ9063-010-1.png?itok=IHPoLm8r',
          'price': 160.00,
          'description': 'Quần thể thao Puma với chất liệu thoáng khí.',
          'categoryId': 2,
        });

        await db.insert('Products', {
          'name': 'Áo khoác mùa đông nam',
          'imageUrl':
              'https://thoitrangsi.vn/wp-content/uploads/2024/07/TS218D.jpg',
          'price': 220.00,
          'description': 'Áo khoác mùa đông với lớp lót giữ nhiệt tốt.',
          'categoryId': 1,
        });

        await db.insert('Products', {
          'name': 'Giày Nike Air Max',
          'imageUrl':
              'https://product.hstatic.net/200000278317/product/thanh-hung-futsal-giay-da-bong-zocker-inspire-pro-tf-sns-005-cam-1_79196b0691854a9b93e60369e8905201_master.jpg',
          'price': 250.00,
          'description': 'Giày Nike Air Max với thiết kế năng động.',
          'categoryId': 2,
        });

        await db.insert('Products', {
          'name': 'Áo khoác chống nắng Uniqlo',
          'imageUrl': 'https://thoitrangsi.vn/wp-content/uploads/2024/07/TS218R.jpg',
          'price': 130.00,
          'description': 'Áo khoác chống nắng thoáng mát từ Uniqlo.',
          'categoryId': 1,
        });

        await db.insert('Products', {
          'name': 'Mũ lưỡi trai thể thao',
          'imageUrl':
              'https://www.ketnoitieudung.vn/data/bt7/non-luoi-trai-makita-1708309830.png',
          'price': 40.00,
          'description': 'Mũ lưỡi trai thể thao cho nam nữ.',
          'categoryId': 3,
        });

        await db.insert('Products', {
          'name': 'Balo du lịch thể thao',
          'imageUrl':
              'https://bitex.com.vn/vnt_upload/news/08_2019/xBalo-mau-giao-hinh-thu-de-thuong-cho-cac-be-mam-non-02.jpg.pagespeed.ic.mx92kQjBXN.jpg',
          'price': 300.00,
          'description': 'Balo thể thao tiện lợi, chống thấm nước.',
          'categoryId': 3,
        });

        await db.insert('Address', {
          'name': 'wonderful quynh',
          'userId': 1,
          'country': 'vietnamese',
          'city': 'ha noi',
          'phoneNumber': '0869865871',
          'address': 'kieu mai ,bac tu liem',
        });

        await db.insert('ProductSizes', {
          'productId': 1,
          'size': 'S',
        });
        await db.insert('ProductSizes', {
          'productId': 1,
          'size': 'M',
        });
        await db.insert('ProductSizes', {
          'productId': 1,
          'size': 'L',
        });
        await db.insert('ProductSizes', {
          'productId': 1,
          'size': 'XL',
        });
        await db.insert('ProductSizes', {
          'productId': 1,
          'size': '2XL',
        });

        await db.insert('ProductSizes', {
          'productId': 2,
          'size': 'S',
        });
        await db.insert('ProductSizes', {
          'productId': 2,
          'size': 'M',
        });
        await db.insert('ProductSizes', {
          'productId': 2,
          'size': 'L',
        });
        await db.insert('ProductSizes', {
          'productId': 2,
          'size': 'XL',
        });
        await db.insert('ProductSizes', {
          'productId': 2,
          'size': '2XL',
        });

        await db.insert('ProductSizes', {
          'productId': 3,
          'size': 'S',
        });
        await db.insert('ProductSizes', {
          'productId': 3,
          'size': 'M',
        });
        await db.insert('ProductSizes', {
          'productId': 3,
          'size': 'L',
        });
        await db.insert('ProductSizes', {
          'productId': 3,
          'size': 'XL',
        });
        await db.insert('ProductSizes', {
          'productId': 3,
          'size': '2XL',
        });

        await db.insert('ProductSizes', {
          'productId': 4,
          'size': '39',
        });

        await db.insert('ProductSizes', {
          'productId': 4,
          'size': '40',
        });
        await db.insert('ProductSizes', {
          'productId': 4,
          'size': '41',
        });

        await db.insert('ProductSizes', {
          'productId': 4,
          'size': '42',
        });
        await db.insert('ProductSizes', {
          'productId': 4,
          'size': '43',
        });
      },
      version: 2, // Phiên bản update khi thay đổi cấu trúc cơ sở dữ liệu
    );
  }
}
