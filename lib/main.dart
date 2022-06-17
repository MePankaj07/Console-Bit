import 'package:console_bit/component/app_bindings.dart';
import 'package:console_bit/constants/color.dart';
import 'package:console_bit/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: primary,
    ));
    return GetMaterialApp(
      title: 'Console Bit',
      defaultTransition: Transition.cupertinoDialog,
      transitionDuration: const Duration(milliseconds: 300),
      popGesture: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xffF8F8F8),
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
          titleSpacing: 0.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      initialBinding: AppBindings(),
      builder: EasyLoading.init(),
    );
  }
}
