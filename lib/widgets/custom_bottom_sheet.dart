import 'package:flutter/material.dart';

class CustomBottomSheet {
  void show(BuildContext context, Widget widget, {Color color = Colors.white}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: color,
      builder: (context) => widget,
    );
  }
}
