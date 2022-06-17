import 'package:console_bit/component/custom_button.dart';
import 'package:console_bit/constants/color.dart';
import 'package:console_bit/constants/size.dart';
import 'package:console_bit/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/assets_path.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.find<AuthController>();
  late bool _passwordVisible;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool validateName() {
    final name = usernameController.text;

    if (name.isNotEmpty) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username cant be empty")));
      return false;
    }
  }

  bool validatePassword() {
    final password = passwordController.text;

    if (password.isNotEmpty) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("password cant be empty")));
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Builder(builder: (context) {
            return ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  getVerticalSpace(30),
                  SvgPicture.asset(loginLogo),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        getVerticalSpace(20),
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Log in to your Account",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: Colors.black),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Please sign in to continue",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(0xff414d5e)),
                          ),
                        ),
                        getVerticalSpace(15),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 30, right: 30),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                              controller: usernameController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  hintText: 'Enter Your User Id',
                                  hintStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black45),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: borderColor)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: borderColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: borderColor))),
                            ),
                          ),
                        ),
                        getVerticalSpace(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                              obscureText: _passwordVisible,
                              decoration: InputDecoration(
                                  // errorText:
                                  //     _validate ? 'Password Can\'t Be Empty' : null,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black45,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black45),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: borderColor)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: borderColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: borderColor))),
                              controller: passwordController,
                            ),
                          ),
                        ),
                        getVerticalSpace(15),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: CustomButton(
                              press: () {
                                if (validateName() && validatePassword()) {
                                  // Future.delayed(const Duration(seconds: 3),
                                  //     () {
                                  authController.login(usernameController.text,
                                      passwordController.text);
                                  // });
                                }
                              },
                              text: 'Login',
                            )),
                      ],
                    ),
                  )
                ]);
          })),
    );
  }
}
