import 'package:flutter/material.dart';
import 'package:shop_zen/data/dao/user_dao.dart';
import 'package:shop_zen/data/models/review.dart';
import 'package:shop_zen/data/models/user.dart';

class ReViewItem extends StatefulWidget {
  const ReViewItem({
    super.key,
    required this.size,
    required this.review,
  });

  final Size size;
  final Review review;

  @override
  State<ReViewItem> createState() => _ReViewItemState();
}

class _ReViewItemState extends State<ReViewItem> {
  User? user; 
  UserDao userDao = UserDao();
  Future<void> foundUser() async {
    User? foundUser = await userDao.findAnUserById(widget.review.id);
    setState(() {
      user = foundUser;
    });
  }
  @override
  void initState() {
    super.initState();
    foundUser();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      height: widget.size.height * 0.18,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg',
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.username ?? 'loading', 
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.timer,
                          size: 18,
                          color: Colors.grey.withOpacity(0.7),
                        )),
                        TextSpan(
                            text: ' ${widget.review.time.substring(0,16)}',
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.7)))
                      ]))
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          text: '${widget.review.star}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          children: [
                        TextSpan(
                          text: ' rating',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        )
                      ])),
                  SizedBox(height: 5),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        size: 15,
                        index < widget.review.star
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
          Text(
            maxLines: 3,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            '${widget.review.content}',
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 17, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
