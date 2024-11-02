import 'package:eco/domain/usecases/auth_cases.dart';

class LoginPresenter {
  AuthCases authCases;
  LoginPresenter(this.authCases);
  Future<void> login(String email, String password) async {
    await authCases.loginUserModel(email: email, password: password);
  }
}
