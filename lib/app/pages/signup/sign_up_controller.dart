import 'package:eco/app/navigators/navigators.dart';
import 'package:eco/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController CpasswordController = TextEditingController();
  var isLoggedIn = false.obs;

  // Signup Method with Validation
  Future<void> signup() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = CpasswordController.text.trim();

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address.");
      return;
    }
    if (password.length < 6) {
      Get.snackbar(
          "Invalid Password", "Password must be at least 6 characters.");
      return;
    }
    if (password != confirmPassword) {
      Get.snackbar(
          "Password Mismatch", "Passwords do not match. Please re-enter.");
      return;
    }

    Utility.showLoader();
    try {
      // Authentication logic here, e.g., await _auth.signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 2)); // Simulating delay
      Utility.closeLoader();
      NavigateTo.gotoDashboardcreen();
    } catch (e) {
      Utility.closeLoader();
      Get.snackbar("Error", "Signup failed. Please try again.");
    }
  }
}
