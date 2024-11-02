// import 'package:dio/dio.dart';
// import 'package:eco/app/utils/utility.dart';
// class ApiService {
//    final Dio dio = Dio(BaseOptions(
//     baseUrl: 'YOUR_BASE_URL', // Define your base URL here
//     connectTimeout: Duration(seconds: 30),
//     receiveTimeout: Duration(seconds: 30),
//   ));

//   ApiService() {
//     dio.interceptors.add(InterceptorsWrapper(
//       onRequest: (options, handler) {
//         // Add headers, logging, or loading indicators
//         Utility.showLoader(); // Show loader when request starts
//         return handler.next(options); // Continue with request
//       },
      
//       onResponse: (response, handler) {
//         Utility.closeLoader(); // Close loader on success
//         return handler.next(response); // Continue with response
//       },
//       onError: (DioError e, handler) {
//         Utility.closeLoader(); // Close loader on error
//         if (e.type == DioExceptionType.sendTimeout) {
//           // Handle connection timeout
//           return handler.next(DioError(
//             requestOptions: e.requestOptions,
//             error: 'Connection Timeout. Please try again.',
//           ));
//         } else if (e.type == DioErrorType.receiveTimeout) {
//           // Handle receive timeout
//           return handler.next(DioError(
//             requestOptions: e.requestOptions,
//             error: 'Receive Timeout. Please try again.',
//           ));
//         } else {
//           // Handle other errors
//           return handler.next(e);
//         }
//       },
//     ));
//   }
// }
