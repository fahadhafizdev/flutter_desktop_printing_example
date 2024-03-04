//untuk print jika mode debug
import 'package:flutter/foundation.dart';
import 'dart:developer' as d;

void logSys(String message, {String title = ''}) {
  if (kDebugMode) {
    d.log(message, name: title);
  }
}
