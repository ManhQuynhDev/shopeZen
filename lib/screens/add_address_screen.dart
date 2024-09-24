import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_zen/data/dao/address_dao.dart';
import 'package:shop_zen/data/dao/user_dao.dart';
import 'package:shop_zen/data/models/address.dart';
import 'package:shop_zen/data/models/user.dart';
import 'package:shop_zen/screens/widget/show_message_widget.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  UserDao userDao = UserDao();

  int userId = 0;

  bool isAgree = false;

  AddressDao addressDao = AddressDao();

  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(key);

    if (token != null && token.isNotEmpty) {
      print('Token: $token');
      return token;
    } else {
      print('Token is null or empty');
      return null;
    }
  }

  Future<void> foundUser(String key) async {
    String? username = await getData(key); // Sử dụng await để lấy giá trị
    if (username != null) {
      User? user = await userDao.findAnUser(username);
      if (user != null) {
        setState(() {
          userId = user.id;
        });
      } else {
        print('User not found');
      }
    } else {
      print('Username is null');
    }
  }

  @override
  void initState() {
    super.initState();
    foundUser('userToken'); // Truyền key trực tiếp
  }

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
                        controller: _nameController,
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
                                  controller: _countryController,
                                  decoration: InputDecoration(
                                    hintText: 'India',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                  controller: _cityController,
                                  decoration: InputDecoration(
                                    hintText: 'Mumbai',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.numberWithOptions(),
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
                        controller: _addressController,
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
                          Switch(
                              value: isAgree,
                              onChanged: (value) {
                                setState(() {
                                  isAgree = value;
                                });
                              })
                        ],
                      )
                    ],
                  ),
                ),

                //code here
                ElevatedButton(
                    onPressed: () async {
                      Address address = Address(
                          id: 0,
                          userId: userId,
                          name: _nameController.text,
                          country: _countryController.text,
                          city: _cityController.text,
                          phoneNumber: _phoneNumberController.text,
                          address: _addressController.text);

                      bool isSucess = await addressDao.insertAddress(address);
                      if (isSucess) {
                        Navigator.pop(context);
                      } else {
                        showMessage(context, 'Add address not sucessfully');
                      }
                    },
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
