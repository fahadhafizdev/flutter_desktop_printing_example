import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';
import 'package:flutter_printer/app/modules/home/components/printer_settings/choose_api.dart';
import 'package:flutter_printer/app/modules/home/components/printer_settings/choose_paper.dart';
import 'package:flutter_printer/app/modules/home/components/printer_settings/choose_printer.dart';
import 'package:flutter_printer/app/modules/home/components/printer_settings/system_log/system_log.dart';
import 'package:flutter_printer/app/utils/extension/extension.dart';
import 'package:flutter_printer/download_pdf_service.dart';
import 'package:flutter_printer/pdf_preview.dart';
import 'package:flutter_printer/printer_service_printing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:printing/printing.dart';

class PrinterSettings extends StatelessWidget {
  const PrinterSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        decoration: BoxDecoration(
          color: AppColor.cGrey7,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Printer Settings',
              style: AppFont.interBlack1.copyWith(
                fontWeight: AppFont.semiBold,
              ),
            ),
            24.0.height,
            Container(
              width: AppDimen.wInfinit,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColor.cWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChoosePrinter(),
                  // 24.0.height,
                  // ChoosePaper(),
                ],
              ),
            ),
            24.0.height,
            const SystemLog(),
          ],
        ),
      ),
    );
  }
}
