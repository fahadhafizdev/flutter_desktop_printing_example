import 'package:flutter/material.dart';

class UtilShowDialogTools {
  Future<void> show(BuildContext context, Widget widget) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => widget,
    );
  }
}
