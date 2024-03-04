import 'package:flutter/material.dart';

import 'app_color.dart';

class AppButtonStyle {
  static ButtonStyle btnDefault = ElevatedButton.styleFrom(
    backgroundColor: AppColor.cBlue2,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  );

  static ButtonStyle btnDisable = ElevatedButton.styleFrom(
    backgroundColor: AppColor.cGrey1,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  );

  static ButtonStyle btnOutlane = ElevatedButton.styleFrom(
    backgroundColor: AppColor.cWhite,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      side: BorderSide(color: AppColor.cBlue2, width: 2.0),
    ),
  );

  static ButtonStyle btnBlue = ElevatedButton.styleFrom(
    backgroundColor: AppColor.cBlue,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  );

  static ButtonStyle btnOrange = ElevatedButton.styleFrom(
    backgroundColor: AppColor.corange,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  );

  static ButtonStyle btnRed = ElevatedButton.styleFrom(
    backgroundColor: AppColor.cRed3,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  );

  static ButtonStyle btnDarkGrey = ElevatedButton.styleFrom(
    backgroundColor: AppColor.cDarkGrey,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  );

  static ButtonStyle btnBlueOutlane = ElevatedButton.styleFrom(
    backgroundColor: AppColor.cWhite,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      side: BorderSide(color: AppColor.cBlue, width: 2.0),
    ),
  );

  static ButtonStyle btnGreenOutlane = ElevatedButton.styleFrom(
    backgroundColor: AppColor.cWhite,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      side: BorderSide(color: AppColor.cGreen, width: 2.0),
    ),
  );

  static ButtonStyle btnGreyOutlane = ElevatedButton.styleFrom(
    backgroundColor: AppColor.cWhite,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      side: BorderSide(color: AppColor.cGrey2, width: 2.0),
    ),
  );
}
