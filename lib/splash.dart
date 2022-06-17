import 'dart:async';
import 'dart:io';

import 'package:console_bit/constants/assets_path.dart';
import 'package:console_bit/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/size.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String status = 'Loading items';

  bool loading = true;
  AuthController authController = Get.find<AuthController>();

  Future<bool> hasConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      authController.validateLogin();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return OrientationBuilder(
            builder: (ctx, orientation) {
              ResponsiveSize.init(ctx, orientation);
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getVerticalSpace(300),
                      Center(
                          child: Image.asset(
                        splashLogo,
                        width: getScreeWidth(2000),
                        height: getScreenHeight(150),
                      )),
                      // Text(
                      //   'Welcome to Console Bit',
                      //   style: TextStyle(
                      //     fontSize: getTextSize(22),
                      //     fontWeight: FontWeight.w500,
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: getScreenHeight(50),
                          right: 0.0,
                          left: 0.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color.fromARGB(255, 0, 0, 0)),
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    backgroundColor:
                                        Color.fromARGB(255, 151, 141, 141),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
