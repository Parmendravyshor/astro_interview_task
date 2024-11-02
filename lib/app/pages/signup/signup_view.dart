import 'package:eco/app/pages/signup/widget/signup_widget.dart';
import 'package:flutter/material.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignupWidget(),
    );
  }
}
