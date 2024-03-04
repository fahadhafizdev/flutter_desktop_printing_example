import 'package:get/get.dart';

import '../controllers/input_saas_url_controller.dart';

class InputSaasUrlBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputSaasUrlController>(
      () => InputSaasUrlController(),
    );
  }
}
