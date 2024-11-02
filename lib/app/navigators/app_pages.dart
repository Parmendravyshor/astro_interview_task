import 'package:eco/app/pages/dashboard/dashboard_binding.dart';
import 'package:eco/app/pages/dashboard/dashboard_view.dart';
import 'package:eco/app/pages/login/login_binding.dart';
import 'package:eco/app/pages/login/login_view.dart';
import 'package:eco/app/pages/signup/sign_up_binding.dart';
import 'package:eco/app/pages/signup/signup_view.dart';
import 'package:eco/app/pages/splash/spalsh_view.dart';
import 'package:eco/app/pages/splash/splash_binding.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static var fadeTransitionDuration = const Duration(milliseconds: 350);
  static var cupertinoTransitionDuration = const Duration(milliseconds: 400);
  static var cupertinoTransition = Transition.cupertino;

  static const initial = Routes.splash;

  static final pages = [
    GetPage<SpalshView>(
        name: Routes.splash,
        page: SpalshView.new,
        transition: Transition.fadeIn,
        binding: SplashBinding(),
        transitionDuration: fadeTransitionDuration),
    GetPage<SignupView>(
        name: Routes.signup,
        page: SignupView.new,
        transition: Transition.fadeIn,
        binding: SignUpBinding(),
        transitionDuration: fadeTransitionDuration),
    GetPage<LoginView>(
        name: Routes.login,
        page: LoginView.new,
        transition: Transition.fadeIn,
        binding: LoginBinding(),
        transitionDuration: fadeTransitionDuration),
    GetPage<DashboardView>(
        name: Routes.dashboard,
        page: DashboardView.new,
        transition: Transition.fadeIn,
        binding: DashboardBinding(),
        transitionDuration: fadeTransitionDuration),
  ];
}
