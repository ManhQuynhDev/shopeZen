import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/review_dao.dart';
import 'package:shop_zen/data/models/review.dart';
import 'package:shop_zen/screens/add_reviews_screen.dart';
import 'package:shop_zen/screens/widget/review_item_widget.dart';

class ReviewsScreen extends StatefulWidget {
  final int productId;
  final String userToken;
  const ReviewsScreen(
      {super.key, required this.productId, required this.userToken});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<Review> listReViews = [];
  ReviewDao reviewDao = ReviewDao();
  Future<void> loadData() async {
    List<Review> list = await reviewDao.getAllListData(widget.productId);
    setState(() {
      listReViews = list;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Reviews',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${listReViews.length} Reviews',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          '4.8',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 5),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              size: 15,
                              index < 4
                                  ? Icons.star
                                  : Icons
                                      .star_border, // Hiển thị sao đầy hoặc sao trống
                              color: Colors.amber,
                            );
                          }),
                        )
                      ],
                    )
                  ],
                ),
                InkWell(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddReviewsScreen(
                                productId: widget.productId,
                                userToken: widget.userToken)))
                  },
                  child: Container(
                    width: size.width * 0.35,
                    height: size.width * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff4A4E69)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.edit_square,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          'Add Review',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: listReViews.length,
              itemBuilder: (context, index) {
                return ReViewItem(size: size, review: listReViews[index]);
              },
            ))
          ],
        ),
      ),
    );
  }
}
