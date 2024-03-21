import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';
import 'package:flutter_printer/app/modules/home/components/home_menu/home_menu.dart';
import 'package:flutter_printer/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_printer/app/utils/extension/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController c = Get.find();

    Widget dotStatus(bool status) {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: status ? AppColor.cGreen : AppColor.cRed3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/light.png',
              height: 5.sp,
              width: 5.sp,
            ),
            const SizedBox(width: 5),
            Text(
              'Fast Print : ${status ? 'Active' : 'Inactive'}',
              style: TextStyle(
                color: AppColor.white1,
              ),
            )
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: AppColor.cGrey7,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          //NOTE : USER EMAIL
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.cGrey1,
            ),
            child: const Icon(
              Icons.person,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Obx(
            () => c.loadProfile.value
                ? const SizedBox(
                    width: 100,
                    child: LinearProgressIndicator(color: Colors.grey))
                : Text(c.userModel.id != null ? c.userModel.email! : '-'),
          ),
          const SizedBox(width: 24),

          //NOTE : USER WAREHOUSE
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.cGrey1,
            ),
            child: const Icon(
              Icons.home_work,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Obx(
            () => c.loadProfile.value
                ? const SizedBox(
                    width: 100,
                    child: LinearProgressIndicator(color: Colors.grey))
                : Text(c.userModel.id != null
                    ? c.userModel.warehouse!.name ?? ''
                    : '-'),
          ),
          const Spacer(),
          Obx(
            () => c.loadProfile.value
                ? const SizedBox.shrink()
                : dotStatus(c.userModel.fastPrint!),
          ),
          const SizedBox(width: 24),
          const HomeMenu(),
        ],
      ),
    );
  }
}
