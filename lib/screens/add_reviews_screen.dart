import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/review_dao.dart';
import 'package:shop_zen/data/dao/user_dao.dart';
import 'package:shop_zen/data/models/review.dart';
import 'package:shop_zen/data/models/user.dart';
import 'package:shop_zen/main.dart';
import 'package:shop_zen/screens/details_screen.dart';
import 'package:shop_zen/screens/home_screen.dart';
import 'package:shop_zen/screens/widget/show_message_widget.dart';

class AddReviewsScreen extends StatefulWidget {
  final int productId;
  final String userToken;
  const AddReviewsScreen(
      {super.key, required this.productId, required this.userToken});

  @override
  State<AddReviewsScreen> createState() => _AddReviewsScreenState();
}

class _AddReviewsScreenState extends State<AddReviewsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  double _star = 0;
  bool _isErrorTitle = false;
  bool _isErrorContent = false;
  bool _isCheck = false;

  UserDao userDao = UserDao();

  ReviewDao reviewDao = ReviewDao();
  @override
  void dispose() {
    // Giải phóng bộ điều khiển khi widget bị huỷ
    _titleController.dispose();
    _contentController.dispose();
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
          title: const Center(
            child: Text(
              'Reviews',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: size.width,
            height: size.height * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height * 0.55,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          suffixIcon: _isCheck == false
                              ? null
                              : _isErrorContent
                                  ? Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    )
                                  : Icon(Icons.done, color: Colors.green),
                          hintText: 'Type your name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true, // Kích hoạt nền
                          fillColor: const Color(0xffF5F6FA),
                        ),
                      ),
                      const Text(
                        'How was your experience?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        controller: _contentController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          suffixIcon: _isCheck == false
                              ? null
                              : _isErrorContent
                                  ? Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    )
                                  : Icon(Icons.done, color: Colors.green),
                          hintText: 'Type your content',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true, // Kích hoạt nền
                          fillColor: const Color(0xffF5F6FA),
                        ),
                      ),
                      const Text(
                        'Star',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              _star.toStringAsFixed(1)), // Hiển thị giá trị sao
                          Expanded(
                            child: Slider(
                              value: _star,
                              min: 0.0,
                              max: 5.0,
                              divisions: 50, // Tùy chọn số bước chia nhỏ
                              activeColor: Colors.blue,
                              inactiveColor: Colors.blue.withOpacity(0.1),
                              onChanged: (double value) {
                                setState(() {
                                  _star = value;
                                });
                              },
                            ),
                          ),
                          const Text('5.0'),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Icon(
                          _star >= 4.0
                              ? Icons.sentiment_very_satisfied_outlined
                              : _star >= 2.0
                                  ? Icons.sentiment_satisfied_outlined
                                  : Icons.sentiment_neutral,
                          color: Colors.amber, // Màu của biểu tượng
                          size: 35, // Kích thước biểu tượng
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isCheck = true;
                    });
                    // Lấy giá trị từ các TextField
                    String name = _titleController.text;
                    String content = _contentController.text;

                    if (name.isEmpty) {
                      setState(() {
                        _isErrorTitle = true;
                      });
                    } else {
                      setState(() {
                        _isErrorTitle = false;
                      });
                    }

                    if (content.isEmpty) {
                      setState(() {
                        _isErrorContent = true;
                      });
                    } else {
                      setState(() {
                        _isErrorContent = false;
                      });
                    }

                    if (!_isErrorTitle && !_isErrorContent) {
                      User? user = await userDao.findAnUser(widget.userToken);
                      Review review = Review(
                          id: 0,
                          productId: widget.productId,
                          userId: user!.id,
                          title: name,
                          content: content,
                          star: _star,
                          time: DateTime.now().toString());

                      bool isSucess = await reviewDao.insertReview(review);
                      if (isSucess) {
                        _contentController.text = '';
                        _star = 0;
                        _titleController.text = '';
                        _isCheck = false;
                        showMessage(context, 'Add reviews successfully');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NavigatorApp()));
                      } else {
                        showMessage(context, 'Add reviews not successfully');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width * 0.9, 48),
                    backgroundColor: const Color(0xff4A4E69),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Submit Review',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
