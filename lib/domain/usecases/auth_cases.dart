import 'dart:ffi';

import '../repositories/repository.dart';

class AuthCases {
  AuthCases(this.repository);
  final Repository repository;

  ///get authToken from local.
  Future<String?> getSecureValue(String key) => repository.getSecureValue(key);

  ///Sign in Api Call
  Future<void> loginUserModel({
    required String email,
    required String password,
  }) async =>
      repository.loginUserModel(
        email: email,
        password: password,
      );
}
