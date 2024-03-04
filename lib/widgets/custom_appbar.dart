import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final List<Widget>? actions;
  const CustomAppbar(
      {super.key,
      required this.title,
      required this.appBar,
      this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppFont.interBlack1.copyWith(
          fontWeight: AppFont.bold,
          fontSize: 20.sp,
        ),
      ),
      actions: actions,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Get.back(),
      ),
      backgroundColor: AppColor.white1,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColor.black1),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
