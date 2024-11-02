import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/enums.dart';
import '../../domain/models/response_model.dart';
import '../theme/app_colors.dart';

abstract class Utility {
  static void printDLog(String message) {
    //  Logger().d('${PageConstants.appName}: $message');
  }

  /// Print info log.
  ///
  /// [message] : The message which needed to be print.
  static void printILog(dynamic message) {
    //  Logger().i('${PageConstants.appName}: $message');
  }

  /// Print info log.
  ///
  /// [message] : The message which needed to be print.
  static void printLog(dynamic message) {
    Logger().log(Level.info, message);
  }

  /// Print error log.
  ///
  /// [message] : The message which needed to be print.
  static void printELog(String message) {
    // Logger().e('${PageConstants.appName}: $message');
  }

  ///Method will return string if any error occurs.
  ///
  /// for at least one numeric digit.
  /// for at least one capital letter.
  /// for at least one special character and at least 6 digits.
  /// /// return [List<bool>] for each case.
  /// Validation logic
  /// r'^
  ///   (?=.*[A-Z])             // should contain at least one upper case
  ///   (?=.*?[0-9])            // should contain at least one digit
  ///  (?=.*?[!@#\$&*~]).{8,}   // should contain at least one Special character
  /// $
  /// This password method is only for reference, it will not gonna use in this
  /// project as no password required in whole project.
  static String? validatePassword(String value) {
    if (value.trim().isNotEmpty) {
      if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        if (value.contains(RegExp(r'[A-Z]'))) {
          if (value.contains(RegExp(r'[0-9]'))) {
            if (value.length < 6) {
              return 'ShouldBe6Characters'.tr;
            } else {
              return null;
            }
          } else {
            return 'ShouldHaveOneDigit'.tr;
          }
        } else {
          return 'ShouldHaveOneUppercaseLetter'.tr;
        }
      } else {
        return 'shouldHaveOneSpecialCharacter'.tr;
      }
    } else {
      return 'PasswordRequired'.tr;
    }
  }

  ///Returns true if email is valid.

  static bool emailValidator(String email) => EmailValidator.validate(email);

  /// Returns true if the internet connection is available.
  static Future<bool> isNetworkAvailable() async =>
      await InternetConnectionChecker().hasConnection;

  ///Print the details of the response.
  // static void printResponseDetails(Response? response) {
  //   if (response != null) {
  //     var isOkay = response;
  //     var statusCode = response.statusCode;
  //     var method = response.request?.method ?? '';
  //     var path = response.request?.url.path ?? '';
  //     var query = response.request?.url.queryParameters ?? '';
  //     if (isOkay) {
  //       printLog(
  //           'Path:$path, Method:$method, Status Text:$statusCode, Query:$query');
  //     } else {
  //       printELog(
  //           'Path:$path, Method:$method, Status Text:$statusCode, Query:$query');
  //     }
  //   }
  // }

  /// returns the date time in particular given format
  static String getWeekDayMonthNumYear(DateTime dateTime) =>
      DateFormat.yMMMMEEEEd().format(dateTime);

  /// get formatted [DateTime] eg. 12-01-2021
  static String getDayMonthYear(DateTime dateTime) =>
      '${getOnlyDate(dateTime)}-${DateFormat('MM').format(dateTime)}-${DateFormat.y().format(dateTime)}';

  /// get formatted [DateTime] eg. 12
  static String getOnlyDate(DateTime dateTime) =>
      DateFormat('dd').format(dateTime);

  /// get formatted [DateTime] eg. 12 Sep
  static String getDateAndMonth(DateTime dateTime) =>
      DateFormat('dd MMM').format(dateTime);

  /// get formatted [DateTime]
  static String getWeekDay(DateTime dateTime) =>
      DateFormat.EEEE().format(dateTime);

  ///Show Loader.
  static void showLoader() async {
    await Get.dialog(
        Center(
          child: LoadingAnimationWidget.discreteCircle(
              secondRingColor: AppColors.secondaryColor,
              thirdRingColor: AppColors.greyText,
              color: AppColors.primaryColor,
              size: 40),
        ),
        barrierColor: AppColors.blackColor.withOpacity(0.7),
        barrierDismissible: false);
  }

  ///Close Loader.
  static void closeLoader() {
    closeDialog();
  }

  ///Show info Dialogue. In which we can show a normal message like any
  ///information regarding anything.
  static void showDialogue(String message) async {
    await Get.dialog(CupertinoAlertDialog(
      title: const Text('Info'),
      content: Text(message),
      actions: [TextButton(onPressed: Get.back, child: const Text('Okay'))],
    ));
  }

  ///Show info Dialogue. In which we can show a normal message like any
  ///information regarding anything.
  static void showInfoAndNavigateDialogue(
      String message, VoidCallback onPressed) async {
    await Get.dialog(CupertinoAlertDialog(
      title: const Text('Info'),
      content: Text(message),
      actions: [TextButton(onPressed: onPressed, child: const Text('Okay'))],
    ));
  }

  ///Show dialogue box as alert box, in which user have two choices yes or no
  ///for eg:-Are you sure you want to quit, Options are yes or no.
  static void showAlertDialogue(
      String? message, String? title, Function()? onPress) async {
    await Get.dialog(CupertinoAlertDialog(
      title: Text('$title'),
      content: Text('$message'),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onPress,
            child: const Text('Yes')),
        const CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: closeDialog,
          child: Text('No'),
        )
      ],
    ));
  }

  /// Dialog to ask user to enable a service which is required to perform
  /// some operation.
  ///
  /// [title] : The title of the service required.
  /// [message] : The message of the service required.
  // static void askToEnableServiceFromSetting(
  //   String title,
  //   String message,
  //   BuildContext context, {
  //   required Function()? onPressed,
  // }) {
  //   Get.dialog(CupertinoAlertDialog(
  //     title: Text(
  //       title,
  //       style: TextStyles.darkBlack20,
  //     ),
  //     content: Text(
  //       message,
  //       style: TextStyles.darkMedium14,
  //     ),
  //     actions: <Widget>[
  //       CupertinoDialogAction(
  //         onPressed: onPressed,
  //         isDefaultAction: true,
  //         child: const Text(
  //           "Yes",
  //         ),
  //       ),
  //       CupertinoDialogAction(
  //         onPressed: () {
  //           Get.back<void>();
  //         },
  //         child: const Text("No"),
  //       )
  //     ],
  //   ));
  // }

  ///Close any open dialogue
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  ///Close any open snack bar.
  static void closeSnackBar() {
    if (Get.isSnackbarOpen) {
      Get.back<void>();
    }
  }

  ///show no internet dialogue if internet is not available.
  static Future<void> showNoInternetDialogue() async {
    await Get.dialog<void>(
        const Center(
            // child: NoInternetWidget(),
            ),
        barrierDismissible: false);
  }

  ///Show a floating snack Bar in which, Can show any [message] .
  ///
  /// [message]:message you need to show to the user.
  ///
  ///[messageType]:Type of the message for different background color.
  ///
  ///[onTap]:An event for onTap.
  ///
  ///[actionName]:The name for the action.
  static void showMessage(String? message, MessageType messageType,
      Function()? onTap, String actionName) {
    if (message == null || message.isEmpty) return;
    closeDialog();
    closeLoader();
    closeSnackBar();
    var backgroundColor = Colors.black;
    switch (messageType) {
      case MessageType.error:
        backgroundColor = Colors.red;
        break;
      case MessageType.information:
        backgroundColor = Colors.black.withOpacity(0.7);
        break;
      case MessageType.success:
        backgroundColor = AppColors.primaryColor;
        break;
      default:
        backgroundColor = Colors.black;
        break;
    }
    Future.delayed(const Duration(seconds: 0), () {
      Get.rawSnackbar(
          messageText: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          mainButton: TextButton(
            onPressed: onTap ?? Get.back,
            child:
                Text(actionName, style: const TextStyle(color: Colors.white)),
          ),
          backgroundColor: backgroundColor,
          margin: const EdgeInsets.all(15.0),
          borderRadius: 15,
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  static String getFormatedDate(String date) {
    var date = DateTime.parse('2018-04-10T04:00:00.000Z');
    return Utility.getDayMonthYear(date);
  }

  /// Show error dialog from response model, eg:- if response is not 200 and it has any error then
  /// this dialogue box show the error message from that response model.
  static void showInfoDialog(ResponseModel data,
      [bool isSuccess = false]) async {
    await Get.dialog(
      CupertinoAlertDialog(
        title: Text(isSuccess ? 'SUCCESS' : 'ERROR'),
        content: Text(
          jsonDecode(data.data)['returnMessage'],
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: Get.back,
            isDefaultAction: true,
            child: Text(
              'okay'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
