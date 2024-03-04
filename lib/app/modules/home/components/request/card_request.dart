import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';
import 'package:flutter_printer/app/config/theme/app_color.dart';
import 'package:flutter_printer/app/data/models/request_model.dart';
import 'package:flutter_printer/app/utils/extension/app_log.dart';
import 'package:flutter_printer/app/utils/extension/extension.dart';
import 'package:flutter_printer/download_pdf_service.dart';
import 'package:flutter_printer/pdf_preview.dart';
import 'package:flutter_printer/printer_service_printing.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class CardRequest extends StatelessWidget {
  final RequestModel data;
  const CardRequest({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Widget dotStatus(String value, Color color) {
      return Row(
        children: [
          Container(
            height: 5,
            width: 5,
            decoration: BoxDecoration(
              color: AppColor.cGreen,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          2.0.width,
          Text(
            value,
            style: TextStyle(
              color: color,
            ),
          )
        ],
      );
    }

    return GestureDetector(
      onTap: () async {
        Printing.directPrintPdf(
          printer: Printer(url: 'HP printer zx250', name: 'HP printer zx250'),
          onLayout: (PdfPageFormat format) async => data.docUrl,
          name: 'document',
          format: PdfPageFormat.a4,
        );
        Printing.info().printInfo(info: 'START PRINT');
        Printing.info().asStream().listen((event) {
          logSys(title: 'PRINTING INFO', '$event');
        });
        Printing.info().printError(
            info: 'PRINT ERROR',
            logFunction: (data) {
              logSys('FAILED PRINT', title: 'FAILED PRINTER');
            });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: IntrinsicHeight(
          child: PdfPreview.builder(
            previewPageMargin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            build: (format) {
              logSys('$data', title: 'PRINTER');
              return data.docUrl;
            },
            useActions: false,
            pdfPreviewPageDecoration: BoxDecoration(
              color: AppColor.cRed,
            ),
            pagesBuilder: (context, pages) {
              return Container(
                padding: const EdgeInsets.all(10),
                color: AppColor.white1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       data.title,
                    //       style: TextStyle(
                    //         color: AppColor.cBlack,
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //     dotStatus('Printing', AppColor.cGreen),
                    //   ],
                    // ),
                    Text(
                      data.title,
                      style: TextStyle(
                        color: AppColor.cBlack,
                        fontSize: 16,
                      ),
                    ),
                    3.0.height,
                    dotStatus('${pages.length} page', AppColor.cBlue),
                  ],
                ),
              );
            },
            onPrinted: (context) {
              logSys(title: 'ON PRINTER', 'on printer init finish');
            },
            onPrintError: (context, error) {
              logSys(title: 'ERROR PRINTER', '$error');
            },
          ),
        ),
      ),
    );
  }
}
