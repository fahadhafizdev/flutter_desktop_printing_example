import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_printer/app/config/theme/app_url.dart';
import 'package:flutter_printer/app/data/services/custom_service.dart';
import 'package:flutter_printer/app/data/services/share_preference_service.dart';
import 'package:flutter_printer/app/utils/extension/app_log.dart';
import 'package:flutter_printer/app/utils/extension/method_enum.dart';
import 'package:flutter_printer/app/utils/util_snackbar.dart';
import 'package:get/get.dart';

class InputSaasUrlController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkToken();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  RxBool loadCheckToken = false.obs;
  Future<void> checkToken() async {
    String token = '';
    loadCheckToken(true);
    Timer(const Duration(seconds: 3), () async {
      await SharedPrefferenceService().getToken().then((value) {
        token = value ?? '';
      });
      logSys('token splash: $token');

      loadCheckToken(false);

      if (token.isEmpty || token == '') {
        baseUrl = dotenv.env['API_BASE_URL_SAAS']!;
        loadCheckToken(false);
        return;
      } else {
        // set url saas
        await SharedPrefferenceService().getUrl().then((value) {
          baseUrl = value ?? '';
        });

        //if baseurl kosong return
        if (baseUrl.isEmpty) {
          loadCheckToken(false);
          return;
        }

        Get.offAndToNamed('/home');
      }
      loadCheckToken(false);
    });
  }

  RxBool isLoading = false.obs;
  Future<void> postUrlSaas({required String url}) async {
    logSys('$baseUrlSaas/saas-clients', title: 'link');
    if (url.isEmpty) {
      UtilSnackBar().show(title: 'Message', message: 'Please input your url');
      return;
    }
    if (isLoading.value) return;

    isLoading(true);
    try {
      var data = await CustomService().request(
        title: 'input url saas',
        url: '$baseUrlSaas/saas-clients',
        method: Method.POST,
        withToken: false,
        params: {"app_url": "$url.kelola.id"},
      );

      if (data['result']['status'] == "active") {
        baseUrl = data['result']['api_url'];
        // baseUrl = 'https://api-staging.kelola.id/staff';
        SharedPrefferenceService().saveUrl(baseUrl);
        Get.toNamed('/login');
      } else {
        UtilSnackBar()
            .show(title: 'Error Message', message: 'Failed get app url');
      }

      logSys('res url saas $url.kelola.id : $data');

      isLoading(false);
    } catch (e) {
      isLoading(false);
      UtilSnackBar().show(
          title: 'Error Message',
          message: e.toString().replaceAll('Exception:', ''));
    }
  }
}
