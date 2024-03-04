import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';
import 'package:flutter_printer/app/utils/extension/extension.dart';
import 'package:flutter_printer/widgets/custom_button.dart';
import 'package:flutter_printer/widgets/custom_text_field.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController emailCtx = TextEditingController(text: '');
    TextEditingController passwordCtx = TextEditingController(text: '');

    Widget inputEmail() {
      return CustomTextField(
        controller: emailCtx,
        hint: 'Email',
        prefixIcons: const Icon(Icons.email_outlined),
      );
    }

    Widget inputPassword() {
      return Obx(
        () => CustomTextField(
          isPassword: !controller.isShowPassword.value,
          controller: passwordCtx,
          hint: 'Password',
          prefixIcons: const Icon(Icons.lock_outline),
          suffixIcons: GestureDetector(
            onTap: () {
              controller.isShowPassword.value =
                  !controller.isShowPassword.value;
            },
            child: controller.isShowPassword.value
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          ),
        ),
      );
    }

    Widget btnLogin() {
      return Obx(() => CustomButton(
            width: double.infinity,
            isLoading: controller.isLoading.value,
            func: () => controller.login(
                email: emailCtx.text, password: passwordCtx.text),
            text: 'Login',
            btnStyle: AppButtonStyle.btnDarkGrey,
          ));
    }

    Widget logoSaas() {
      return IntrinsicHeight(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColor.black1,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColor.white1,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/logov2.png',
                height: 150,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColor.cGrey1,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              logoSaas(),
              24.0.height,
              inputEmail(),
              14.0.height,
              inputPassword(),
              18.0.height,
              btnLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
