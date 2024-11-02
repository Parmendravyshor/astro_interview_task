import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../app/utils/utility.dart';
import '../../domain/entities/enums.dart';
import '../../domain/models/response_model.dart';

///This class can call all the APIs and handle error status code.
class ApiWrapper {
  final String _baseUrl = 'http://airmymd.smallbizplace.com/api/';

  ///Method to make call all types of request like get,post,put,delete.
  Future<ResponseModel> makeRequest(String url, Request request, dynamic data,
      bool isLoading, Map<String, String> headers,
      {String? field, String? filePath}) async {
    ///Checking network available or not...
    if (await Utility.isNetworkAvailable()) {
      switch (request) {
        ///Method to call get type request.
        case Request.get:
          {
            var uri = _baseUrl + url;
            if (isLoading) Utility.showLoader();
            try {
              final response = await http
                  .get(Uri.parse(uri), headers: headers)
                  .timeout(const Duration(seconds: 60));
              print(data);
              print(response.statusCode);
              print(response.body);
              print(headers);
              Utility.closeLoader();
              Utility.printLog(uri);
              return returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"message":"Request Timed Out"}', hasError: true);
            }
          }

        ///Method to call post type request.
        case Request.post:
          {
            var uri = _baseUrl + url;

            try {
              if (isLoading) Utility.showLoader();
              final response = await http
                  .post(Uri.parse(uri),
                      body: json.encode(data), headers: headers)
                  .timeout(const Duration(seconds: 30));
              print(data);
              print(response.statusCode);
              print(response.body);
              print(headers);
              Utility.closeDialog();

              Utility.printILog(uri);

              return returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"message":"Request timed out"}', hasError: true);
            }
          }

        ///Method to call put type request.
        case Request.put:
          {
            var uri = _baseUrl + url;
            if (isLoading) Utility.showLoader();
            try {
              final response = await http
                  .post(Uri.parse(uri), headers: headers)
                  .timeout(const Duration(seconds: 60));
              Utility.closeLoader();
              Utility.printLog(uri);
              return returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"message":"Request Timed Out"}', hasError: true);
            }
          }

        ///Method to call delete type request.
        case Request.delete:
          {
            var uri = _baseUrl + url;
            if (isLoading) Utility.showLoader();
            try {
              final response = await http
                  .post(Uri.parse(uri), headers: headers)
                  .timeout(const Duration(seconds: 60));
              Utility.closeLoader();
              Utility.printLog(uri);
              return returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"message":"Request Timed Out"}', hasError: true);
            }
          }

        case Request.multiPartPost:
          {
            var uri = _baseUrl + url;
            if (isLoading) Utility.showLoader();
            var name = File(filePath.toString());
            List<int> size = [];
            try {
              var request = http.MultipartRequest('POST', Uri.parse(uri))
                ..headers.addAll(headers)
                ..fields.addAll(data)
                ..files.add(http.MultipartFile(
                    field!,
                    File(filePath!).readAsBytes().asStream(),
                    File(filePath).lengthSync(),
                    filename: filePath.split("/").last));

              var streamedResponse = await request.send();
              Utility.closeDialog();
              var response = await http.Response.fromStream(streamedResponse);
              print('This is multipart response${response.body}');

              // response.stream.transform(utf8.decoder).listen((value) {
              //   print(value);
              //
              // });
              print(
                  'This is multipart streamed response${streamedResponse.toString()}');
              return returnResponse(response);
            } on TimeoutException catch (_) {
              return ResponseModel(
                  data: '{"message":"Request timed out"}', hasError: true);
            }
          }
      }
    }

    /// If there is no network available then instead of print can show the no internet widget too
    else {
      Get.dialog(const Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   AppImages.logo,
              //   scale: 5,
              // ),
              // AppSizeBox.height_10,
              // const Text(
              //   'Ooops!',
              //   style: TextStyles.greyPlain22,
              // ),
              // AppSizeBox.height_5,
              // const Text(
              //   'No internet connection found\n Check your connection',
              //   textAlign: TextAlign.center,
              //   style: TextStyles.greyMedium14,
              // ),
            ],
          ),
        ),
      ));
      return ResponseModel(
          data:
              '{"message":"No internet, please enable mobile data or wi-fi in your phone settings and try again"}',
          hasError: true,
          errorCode: 1000);
    }
  }

  /// Method to return the API response based upon the status code of the server
  ResponseModel returnResponse(http.Response response) {
    if (response.statusCode == 200) {
      switch (jsonDecode(response.body)['returnCode']) {
        case 0:
          return ResponseModel(
              data: response.body,
              hasError: true,
              errorCode: response.statusCode);
        case 1:
          return ResponseModel(
            data: response.body,
            hasError: false,
            errorCode: response.statusCode,
          );
        case 5:
          return ResponseModel(
            data: response.body,
            hasError: true,
            errorCode: response.statusCode,
          );
        default:
          return ResponseModel(
              data: response.body,
              hasError: true,
              errorCode: response.statusCode);
      }
    } else {
      return ResponseModel(
          data: response.body, hasError: true, errorCode: response.statusCode);
    }
  }
}

// /// Method to return the API response based upon the status code of the server
// ResponseModel returnResponse(http.Response response) {
//   switch (response.statusCode) {
//     case 200:
//     case 201:
//     case 202:
//     case 203:
//     case 205:
//     case 208:
//       return ResponseModel(
//           data: response.body,
//           hasError: false,
//           errorCode: response.statusCode);
//     case 400:
//     case 401:
//       return ResponseModel(
//         data: response.body,
//         hasError: true,
//         errorCode: response.statusCode,
//       );
//     case 406:
//       if (response.statusCode == 406) {
//         // connect
//       }
//       return ResponseModel(
//         data: response.body,
//         hasError: true,
//         errorCode: response.statusCode,
//       );
//     case 409:
//     case 500:
//     case 522:
//       return ResponseModel(
//           data: response.body,
//           hasError: true,
//           errorCode: response.statusCode);
//     default:
//       return ResponseModel(
//           data: response.body,
//           hasError: true,
//           errorCode: response.statusCode);
//   }
// }
//