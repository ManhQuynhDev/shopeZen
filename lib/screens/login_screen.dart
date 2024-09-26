import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_zen/data/dao/user_dao.dart';
import 'package:shop_zen/main.dart';
import 'package:shop_zen/screens/widget/show_message_widget.dart';

class LoginScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  static String LOGIN_SCREEN = '/loginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SignUpState();
}

class _SignUpState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isRemember = false;

  bool _isShowPass = true;

  double imageSize = 0.3;

  UserDao userDao = UserDao();

  Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> rememberAccount(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> rememberStatus(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> removeAccount(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> getAccount(key1, key2, key3) async {
    final prefs = await SharedPreferences.getInstance();
    String? username = await prefs.getString(key1);
    String? password = await prefs.getString(key2);
    bool? remember = await prefs.getBool(key3);
    if (username != null && password != null && remember != null) {
      setState(() {
        _usernameController.text = username;
        _passwordController.text = password;
        _isRemember = remember;
      });
    } else {
      _usernameController.text = '';
      _passwordController.text = '';
      _isRemember = false;
    }
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAccount('username', 'password', 'remember');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.topLeft,
                      width: double.infinity,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        child: const Icon(Icons.chevron_left_outlined),
                      ),
                    ),
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                          text: 'WelCome\n',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: 'Please enter your data to continue',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey))
                          ]))
                ],
              ),
              SizedBox(height: 10),
              Image.asset(
                'assets/images/welcome_image.png',
                width: size.height * imageSize,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          labelText: 'Username',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                          controller: _passwordController,
                          obscureText: _isShowPass,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isShowPass =
                                      !_isShowPass; // Thay đổi trạng thái ẩn/hiện mật khẩu
                                });
                              },
                              icon: Icon(
                                _isShowPass ? Icons.remove_red_eye : Icons.key,
                              ),
                            ),
                            icon: const Icon(Icons.keyboard),
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (value!.length < 3) {
                              return 'PassWold very low';
                            } else if (value!.length < 7) {
                              return 'Password low';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.topRight,
                        child: Text('Forgot password?',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Color(0xff525CB5), fontSize: 15)),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Remember me',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Switch(
                              value: _isRemember,
                              onChanged: (value) {
                                setState(() {
                                  _isRemember = value;
                                });
                              })
                        ],
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              const Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text:
                          'By connecting your account confirm that you agree with our ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      children: [
                        TextSpan(
                            text: 'Term and Condition',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600))
                      ])),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool isLoginSucess = await userDao.checkLogin(
                          _usernameController.text,
                          _passwordController.text) as bool;
                      if (isLoginSucess) {
                        // showMessage(context, 'User login successfully');
                        saveData('userToken', _usernameController.text);
                        if (_isRemember == true) {
                          rememberAccount('username', _usernameController.text);
                          rememberAccount('password', _passwordController.text);
                          rememberStatus('remember', _isRemember);
                        } else {
                          removeAccount('username');
                          removeAccount('password');
                          removeAccount('remember');
                        }
                        Navigator.pushNamed(context, NavigatorApp.HOME_SCREEN);
                      } else {
                        showMessage(context, 'Failed to login user');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(107, 48),
                      backgroundColor: Color(0xff4A4E69),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
