import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  static String SIGN_UP_SCREEN = '/signUpScreen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isRemember = false;

  bool _isShowPass = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();

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
                  const Text(
                    'SignUp',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/images/welcome_image.png',
                width: size.height * 0.32,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
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
                      TextFormField(
                          controller: _emailAddressController,
                          decoration: const InputDecoration(
                            icon: const Icon(Icons.email),
                            labelText: 'Email Address',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
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
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(107, 48),
                      backgroundColor: Color(0xff4A4E69),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
