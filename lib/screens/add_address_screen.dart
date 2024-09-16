import 'package:flutter/material.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text('Address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12.0),
          child: SizedBox(
            width: double.infinity,
            height: size.height * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.55,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Country',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                SizedBox(height: 5),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'India',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10)),
                                    filled: true, // Kích hoạt nền
                                    fillColor: Color(0xffF5F6FA),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'City',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                SizedBox(height: 5),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Mumbai',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10)),
                                    filled: true, // Kích hoạt nền
                                    fillColor: Color(0xffF5F6FA),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        'Phone Number',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '+91 8014537533',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          filled: true, // Kích hoạt nền
                          fillColor: Color(0xffF5F6FA),
                        ),
                      ),
                      Text(
                        'Address',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Taj Hotel ',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          filled: true, // Kích hoạt nền
                          fillColor: Color(0xffF5F6FA),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Save as primary address',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Switch(value: false, onChanged: (value) {})
                        ],
                      )
                    ],
                  ),
                ),
            
                //code here
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
