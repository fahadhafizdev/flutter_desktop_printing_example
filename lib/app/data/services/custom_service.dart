import 'dart:convert';
import 'package:flutter_printer/app/utils/extension/method_enum.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';

import '../../utils/extension/app_log.dart';
import 'logger_interceptor.dart';
import 'share_preference_service.dart';

class CustomService {
  Future<dynamic> request({
    required String title,
    required String url,
    required Method method,
    required bool withToken,
    Map<String, dynamic>? params,
  }) async {
    logSys(params.toString());
    late Response response;
    Dio dio = Dio();
    late String token;

    try {
      //NOTE : CHECK WITH TOKEN
      if (withToken) {
        await SharedPrefferenceService().getToken().then((value) {
          token = value!;
        });

        dio = Dio(
          BaseOptions(
            contentType: Headers.jsonContentType,
            connectTimeout: const Duration(milliseconds: 50000),
            receiveTimeout: const Duration(milliseconds: 50000),
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        )..interceptors.addAll([
            LoggerInterceptor(),
          ]);
      } else {
        token = '';
        dio = Dio(
          BaseOptions(
            contentType: Headers.jsonContentType,
            connectTimeout: const Duration(milliseconds: 50000),
            receiveTimeout: const Duration(milliseconds: 50000),
          ),
        )..interceptors.addAll([
            LoggerInterceptor(),
          ]);
      }

      //NOTE : CHECK METHOD API
      if (method == Method.GET) {
        response = await dio.get(url);
      } else if (method == Method.POST) {
        response = await dio.post(url, data: jsonEncode(params));
      } else if (method == Method.DELETE) {
        response = await dio.delete(url);
      } else if (method == Method.PUT) {
        response = await dio.put(url, data: jsonEncode(params));
      }

      //NOTE : CHECK RESPONSE STATUS
      if (response.statusCode == 200) {
        logSys('${response.data}');
        return response.data;
      } else if (response.statusCode == 204) {
        logSys('response 204 : $response');
        return response.data;
      } else if (response.statusCode == 201) {
        return response.data;
      }
    } on DioException catch (e) {
      logSys('code : ${e.response!.data['code']}');

      if (e.response!.data['code'].toString() == 'invalid_token') {
        SharedPrefferenceService().clear();
        Get.offAndToNamed('/input-saas-url');
      }

      throw Exception(e.response!.data['message']);
    }
  }

//   void onError(
//       {required DioError err, required String title, String? message = ''}) {
//     if (err.response!.data['code'].toString() == 'invalid_token') {
//       AuthService().logout();
//       NavigatorKey.navigatorKey.currentContext!.read<PageCubit>().setPage(0);
//       SharedPrefferenceService().clear();
//       Navigator.pushNamedAndRemoveUntil(
//           NavigatorKey.navigatorKey.currentContext!, '/', (route) => false);
//     }

//     logSys('error type ${err.type}');
//     switch (err.type) {
//       case DioErrorType.connectTimeout:
//       case DioErrorType.sendTimeout:
//       case DioErrorType.receiveTimeout:
//         // KelSnackBar().show(title: 'Error Message', message: receiveTimeout);
//         throw receiveTimeout;
//       case DioErrorType.response:
//         int? code = err.response?.statusCode;
//         switch (code) {
//           case 400:
//             // KelSnackBar()
//             // .show(title: 'Error Message', message: message ?? message400);
//             throw message400;
//           case 401:
//             // autoLogout();
//             // KelSnackBar()
//             // .show(title: 'Error Message', message: message ?? message401);
//             throw message401;
//           case 404:
//             // KelSnackBar()
//             // .show(title: 'Error Message', message: message ?? message404);
//             throw message404;
//           case 409:
//             // KelSnackBar()
//             // .show(title: 'Error Message', message: message ?? message409);
//             throw message409;
//           case 500:
//             // KelSnackBar()
//             // .show(title: 'Error Message', message: message ?? message500);
//             throw message500;
//           default:
//             // KelSnackBar().show(title: 'Error Message', message: message ?? '');
//             throw 'Undefinned';
//         }

//       case DioErrorType.cancel:
//         break;
//       case DioErrorType.other:
//         // KelSnackBar().show(title: 'Error Message', message: messageOther);
//         throw messageOther;
//     }
//   }

//   void autoLogout() {
//     AuthService().logout();
//     NavigatorKey.navigatorKey.currentContext!.read<PageCubit>().setPage(0);
//     SharedPrefferenceService().clear();
//     Navigator.pushNamedAndRemoveUntil(
//         NavigatorKey.navigatorKey.currentContext!, '/login', (route) => false);
//   }
}
