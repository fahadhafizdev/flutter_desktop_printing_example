import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

class AppFont {
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;

  static TextStyle tBlackQuickSand = TextStyle(
    color: AppColor.cBlack,
    fontSize: 5.sp,
  );

  static TextStyle interBlack1 = TextStyle(
    color: AppColor.cBlack,
    fontSize: 5.sp,
  );

  static TextStyle interWhite1 = TextStyle(
    color: AppColor.cWhite,
    fontSize: 5.sp,
  );

  static TextStyle interGrey3 = TextStyle(
    color: AppColor.cGrey3,
    fontSize: 5.sp,
  );

  static TextStyle tBlack2QuickSand = TextStyle(
    color: AppColor.cBlack2,
    fontSize: 5.sp,
  );
  static TextStyle tWhiteQuickSand = TextStyle(
    color: AppColor.cWhite,
    fontSize: 5.sp,
  );
  static TextStyle tGrey2QuickSand = TextStyle(
    color: AppColor.cGrey2,
    fontSize: 5.sp,
  );

  static String descCreateInbound =
      'With inbound, you can send your products into a warehouse easily. Ready to do that? Start fill in the data below to do it.';

  static String descCreateOutbound =
      'Outbound is the process of removing goods from the warehouse. You can make outbound requests manually or through orders in the marketplaces.';
}
