import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';
import 'package:flutter_printer/app/utils/extension/extension.dart';
import 'package:flutter_printer/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../controllers/input_saas_url_controller.dart';

class InputSaasUrlView extends GetView<InputSaasUrlController> {
  const InputSaasUrlView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController urlSaasCtx = TextEditingController(text: '');
    Widget inputUrlSaas() {
      return TextFormField(
        controller: urlSaasCtx,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: AppColor.cGrey1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: AppColor.cGrey1),
          ),
          fillColor: AppColor.cWhite,
          filled: true,
          hintText: 'enter your app URL',
          suffixIcon: Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(8, 14, 12, 0),
            decoration: BoxDecoration(
              color: AppColor.cGrey2,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              '.kelola.id',
              style: AppFont.interWhite1.copyWith(
                fontSize: 16,
                fontWeight: AppFont.medium,
              ),
            ),
          ),
        ),
      );
    }

    Widget btnInput() {
      return Obx(() => CustomButton(
            width: double.infinity,
            isLoading: controller.isLoading.value,
            func: () => controller.postUrlSaas(url: urlSaasCtx.text),
            text: 'Submit',
            btnStyle: AppButtonStyle.btnDarkGrey,
          ));
    }

    Widget logoSaas() {
      return Image.asset(
        'assets/icons/logov2.png',
        height: 150,
      );
    }

    Widget content() {
      return Obx(() => controller.loadCheckToken.value
          ? CircularProgressIndicator(color: AppColor.black1)
          : Column(
              children: [
                inputUrlSaas(),
                18.0.height,
                btnInput(),
              ],
            ));
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
              content(),
            ],
          ),
        ),
      ),
    );
  }
}
