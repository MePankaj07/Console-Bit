import 'package:console_bit/constants/api_path.dart';
import 'package:console_bit/dashboard.dart';
import 'package:console_bit/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var userName = ''.obs;
  var token = ''.obs;

  var dio = Dio();
  // RemoteDataController remoteDataController = Get.find<RemoteDataController>();

  validateLogin() {
    var loginPayload = GetStorage().read('loginPayload');
    Get.log(loginPayload.toString());
    Get.log("loginPayload.toString()");

    if (loginPayload != null) {
      isLoggedIn.value = true;
      userName.value = loginPayload['user']['first_name'];
      token.value = loginPayload['access'];
      // remoteDataController.initRemote();

      update();

      Get.offAll(() => const DashBoard());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  login(String username, String password) async {
    EasyLoading.show(status: "Please Wait");
    var data = {"email": username, "password": password};
    try {
      var response = await dio.post(loginUrl,
          data: data,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }));

      GetStorage()
          .write('loginPayload', response.data)
          .then(((value) => validateLogin()));
      EasyLoading.showSuccess("Successfully Logged In");
      return response;
    } catch (e) {
      EasyLoading.showError("Please recheck your credentials");
      Get.log(e.toString());

      EasyLoading.dismiss();

      rethrow;
    }
  }

  logout() async {
    await GetStorage().remove('loginPayload');

    Get.offAll(() => const LoginScreen());
  }
}
