import 'package:flutter_printer/app/config/theme/app_url.dart';
import 'package:flutter_printer/app/data/services/custom_service.dart';
import 'package:flutter_printer/app/data/services/share_preference_service.dart';
import 'package:flutter_printer/app/utils/extension/method_enum.dart';
import 'package:flutter_printer/app/utils/util_snackbar.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  RxBool isLoading = false.obs;
  RxBool isShowPassword = false.obs;
  Future<void> login({required String email, required String password}) async {
    if (isLoading.value) return;

    isLoading(true);
    try {
      var data = await CustomService().request(
          title: 'login service',
          url: '$baseUrl/auth/login',
          method: Method.POST,
          withToken: false,
          params: {
            'email': email,
            'password': password,
          });

      await SharedPrefferenceService()
          .saveToken(data['result']['access_token']);

      await SharedPrefferenceService()
          .saveTokenPubSub(data['result']['pubsub_token'].toString());

      isLoading(false);

      Get.offAndToNamed('/home');
    } catch (e) {
      isLoading(false);
      UtilSnackBar().show(
          title: 'Error Message',
          message: e.toString().replaceAll('Exception:', ''));
    }
  }
}
