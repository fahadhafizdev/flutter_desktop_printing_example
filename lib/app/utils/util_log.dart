import 'package:flutter/material.dart';

class UtilLog {
  Future<void> logPrint({required String title, required dynamic data}) async {
    debugPrint(
        '----------------------------Response $title-------------------------------------------------------\n$data\n------------------------------end $title---------------------------------------------------------');
  }
}
