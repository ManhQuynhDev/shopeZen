import 'package:flutter/material.dart';

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

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                  Container(
                    alignment: Alignment.topLeft,
                    width: double.infinity,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      child: const Icon(Icons.chevron_left_outlined),
                    ),
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
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
                                  _isRemember = !_isRemember;
                                });
                              })
                        ],
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              Text.rich(
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
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('ok');
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
