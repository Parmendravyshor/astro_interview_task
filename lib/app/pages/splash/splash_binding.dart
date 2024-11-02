import 'package:eco/app/pages/splash/spalsh_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SpalshController());
  }
}
