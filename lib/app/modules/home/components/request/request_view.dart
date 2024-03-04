import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';
import 'package:flutter_printer/app/modules/home/components/request/card_request.dart';
import 'package:flutter_printer/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_printer/app/utils/extension/extension.dart';
import 'package:get/get.dart';

class RequestView extends StatelessWidget {
  const RequestView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController c = Get.find();
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        margin: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: AppColor.cGrey7,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request',
              style: AppFont.interBlack1.copyWith(
                fontWeight: AppFont.semiBold,
              ),
            ),
            12.0.height,
            Row(
              children: [
                const Text('Success'),
                2.0.width,
                Text(
                  '10',
                  style: TextStyle(color: AppColor.cGrey3),
                ),
                30.0.width,
                const Text('Failed'),
                2.0.width,
                Text(
                  '5',
                  style: TextStyle(color: AppColor.cGrey3),
                ),
              ],
            ),
            24.0.height,
            Container(
              height: 550,
              width: AppDimen.wInfinit,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColor.cWhite.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                  child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...c.listRequest.map(
                      (element) => CardRequest(data: element),
                    ),
                  ],
                ),
              )),
            ),
            24.0.height,
          ],
        ),
      ),
    );
  }
}
