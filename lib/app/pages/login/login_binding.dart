import 'package:eco/app/pages/login/login_controller.dart';
import 'package:eco/app/pages/login/login_presenter.dart';
import 'package:eco/domain/repositories/repository.dart';
import 'package:eco/domain/usecases/auth_cases.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(
        Get.put(LoginPresenter(Get.put(AuthCases(Get.find<Repository>()))))));
  }
}
