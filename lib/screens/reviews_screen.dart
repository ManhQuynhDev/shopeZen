import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

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
                      '245 Reviews',
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
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  height: size.height * 0.18,
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
                                  'https://images2.thanhnien.vn/528068263637045248/2024/1/25/c3c8177f2e6142e8c4885dbff89eb92a-65a11aeea03da880-1706156293184503262817.jpg',
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
                                    'Ronald Richards',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
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
                                        text: ' 13 Sep, 2020',
                                        style: TextStyle(
                                            color:
                                                Colors.grey.withOpacity(0.7)))
                                  ]))
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: const TextSpan(
                                      text: '4.8',
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
                      const Text(
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        'Lorem ipsum dolor sit amet take care of me , i dont like you,when you go to viris consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: Colors.grey),
                      )
                    ],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
