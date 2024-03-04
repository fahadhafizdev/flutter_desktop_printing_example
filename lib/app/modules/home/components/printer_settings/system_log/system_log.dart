import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';
import 'package:flutter_printer/app/modules/home/components/printer_settings/choose_api.dart';
import 'package:flutter_printer/app/modules/home/components/printer_settings/choose_paper.dart';
import 'package:flutter_printer/app/modules/home/components/printer_settings/choose_printer.dart';
import 'package:flutter_printer/app/modules/home/components/printer_settings/system_log/text_log.dart';
import 'package:flutter_printer/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_printer/app/utils/extension/app_log.dart';
import 'package:flutter_printer/app/utils/extension/extension.dart';
import 'package:flutter_printer/download_pdf_service.dart';
import 'package:flutter_printer/pdf_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';

class SystemLog extends StatelessWidget {
  const SystemLog({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController c = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Log',
          style: AppFont.interBlack1.copyWith(
            fontWeight: AppFont.semiBold,
          ),
        ),
        24.0.height,
        Obx(
          () => Container(
            height: 315,
            width: AppDimen.wInfinit,
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            decoration: BoxDecoration(
              color: AppColor.cWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              controller: c.scrollCtx,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...c.logRequest.map(
                    (element) => TextLog(data: element),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
