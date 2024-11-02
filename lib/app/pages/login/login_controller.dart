import 'package:eco/app/navigators/navigators.dart';
import 'package:eco/app/pages/login/login_presenter.dart';
import 'package:eco/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginPresenter loginPresenter;
  LoginController(this.loginPresenter);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoggedIn = false.obs;

  // Login Method with Validation
  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address.");
      return;
    }
    if (password.length < 6) {
      Get.snackbar(
          "Invalid Password", "Password must be at least 6 characters.");
      return;
    }
    Utility.showLoader();
    try {
      // Authentication logic, e.g., await _auth.signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 2));
      Utility.closeLoader();
      NavigateTo.gotoDashboardcreen();
    } catch (e) {
      Get.snackbar("Error", "Login failed. Check your credentials.");
    }
  }
}
