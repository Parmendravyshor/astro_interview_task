import 'package:get/get.dart';

import 'app_routes.dart';

///These function are used to navigate pages.
abstract class NavigateTo {
  ///This function will navigate to gotoLoginScreen Screen.
  static void gotoLoginScreen() {
    Get.offAllNamed(Routes.login);
  }

  static void gotoDashboardcreen() {
    Get.offAllNamed(Routes.dashboard);
  }

  static void gotoSignupScreen() {
    Get.offAllNamed(Routes.signup);
  }
}
