import 'package:console_bit/constants/api_path.dart';
import 'package:console_bit/controller/auth_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class RemoteDataController extends GetxController {
  var dio = Dio();
  var employeeDetails = [].obs;
  var isDetailsLoading = true.obs;
  AuthController authController = Get.find<AuthController>();

  initRemote() async {
    await fetchEmployee();
  }

  fetchEmployee() async {
    isDetailsLoading.value = true;
    update();
    var headers = {
      "Authorization": "Bearer ${authController.token.value}",
    };
    try {
      var response =
          await dio.get(employeeUrl, options: Options(headers: headers));

      if (response.statusCode == 200) {
        employeeDetails.value = response.data['results'];
        isDetailsLoading.value = false;
        update();
      }
    } on DioError catch (e) {
      if (e.response != null) {
        EasyLoading.showError(e.response!.statusCode.toString().contains("500")
            ? "Server Error"
            : "Unable to proceed request");
      }
    }
  }

  fetchFilterForDesignation(String filter) async {
    isDetailsLoading.value = true;
    update();
    var headers = {
      "Authorization": "Bearer ${authController.token.value}",
    };
    try {
      var response =
          await dio.get(employeeUrl, options: Options(headers: headers));

      if (response.statusCode == 200) {
        List result = response.data['results'];
        employeeDetails.value = result
            .where((element) => element['designation'] == filter)
            .toList();
        Get.log(employeeDetails.toString());
        isDetailsLoading.value = false;
        update();
      }
    } on DioError catch (e) {
      if (e.response != null) {
        EasyLoading.showError(e.response!.statusCode.toString().contains("500")
            ? "Server Error"
            : "Unable to proceed request");
      }
    }
  }

  fetchFilterForSalary(String filter, String filter2) async {
    isDetailsLoading.value = true;
    update();
    var headers = {
      "Authorization": "Bearer ${authController.token.value}",
    };
    try {
      var response =
          await dio.get(employeeUrl, options: Options(headers: headers));

      if (response.statusCode == 200) {
        List result = response.data['results'];

        employeeDetails.value = result.where((element) {
          return ((num.parse(element['salary']) > num.parse(filter)) &&
              (num.parse(element['salary']) < num.parse(filter2)));
        }).toList();

        isDetailsLoading.value = false;
        update();
      }
    } on DioError catch (e) {
      if (e.response != null) {
        EasyLoading.showError(e.response!.statusCode.toString().contains("500")
            ? "Server Error"
            : "Unable to proceed request");
      }
    }
  }
}
