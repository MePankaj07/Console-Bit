import 'package:console_bit/controller/auth_controller.dart';
import 'package:console_bit/controller/remote_data_controller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemoteDataController>(() => RemoteDataController());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
