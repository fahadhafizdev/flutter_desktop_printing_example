import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';
import 'package:flutter_printer/app/modules/home/components/home_header/home_header.dart';
import 'package:flutter_printer/app/modules/home/components/home_menu/home_menu.dart';
import 'package:flutter_printer/app/modules/home/components/printer_settings/printer_settings.dart';
import 'package:flutter_printer/app/modules/home/components/request/request_view.dart';
import 'package:flutter_printer/app/utils/extension/extension.dart';
import 'package:flutter_printer/widgets/custom_button.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.initSocket();
    controller.initLog();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeHeader(),
              12.0.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RequestView(),
                  PrinterSettings(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}