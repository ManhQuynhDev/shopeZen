import 'package:flutter/material.dart';

class AddReviewsScreen extends StatelessWidget {
  const AddReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
          body: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: size.width,
                height: size.height * 0.85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  SizedBox(
                    height: size.height * 0.50,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Type your name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            filled: true, // Kích hoạt nền
                            fillColor: Color(0xffF5F6FA),
                          ),
                        ),
                        Text('How was your experience ?',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black)),
                        TextField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Type your name',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            filled: true, // Kích hoạt nền
                            fillColor: Color(0xffF5F6FA),
                          ),
                        ),
                        Text(
                          'Star',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('0.0'),
                            Expanded(
                              child: Slider(
                                value: 2.5,
                                min: 0.0,
                                max: 5.0,
                                divisions: 50, // Tùy chọn số bước chia nhỏ
                                activeColor:
                                    Colors.blue, // Màu của slider khi hoạt động
                                inactiveColor: Colors.blue.withOpacity(
                                    0.1), // Màu slider khi không hoạt động
                                onChanged: (double value) {},
                              ),
                            ),
                            Text('5.0'),
                          ],
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: size.height * 0.3,
                  //   child: ,
                  // )
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(size.width * 0.9, 48),
                          backgroundColor: Color(0xff4A4E69),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                      child: const Text(
                        'Submit Review',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                ]),
              ))),
    );
  }
}
