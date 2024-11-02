import 'package:eco/domain/entities/enums.dart';

import '../../domain/models/response_model.dart';
import 'api_wrapper.dart';

class ConnectHelper {
  ///Initialize Api wrapper
  final apiWrapper = ApiWrapper();

  ///Register Api===============================================================
  Future<ResponseModel> loginUserModel(String email, String password) async {
    var data = {
      "email": email,
      "password": password,
    };
    return await apiWrapper.makeRequest(
      'login',
      Request.post,
      data,
      true,
      {"Content-Type": "application/json"},
    );
  }
}
