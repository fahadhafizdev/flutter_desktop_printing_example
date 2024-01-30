import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_printer/download_pdf_service.dart';
import 'package:flutter_printer/pdf_preview.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// import 'package:printing/printing_web.dart';

class PrinterServicePrinting {
  void initPdf(BuildContext context, {bool isDirectPrint = false}) async {
    final doc = pw.Document();

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World'),
          ); // Center
        })); // Page

    if (isDirectPrint) {
      List<Printer> dataPrinter = [];
      await Printing.listPrinters().then((value) {
        dataPrinter = value;
      });

      for (var element in dataPrinter) {
        log('printer --> ${element.name}');
      }

      try {
        log('use printer : ${dataPrinter[1].name} ${dataPrinter[1].url}');
        String printSelected = '${dataPrinter[1].name}';
        String printUrl = '${dataPrinter[1].url}';
        var docUrl;
        String baseUrl =
            "https://s3.ap-southeast-1.amazonaws.com/kelola/shopee/label-market/48e432f1-d762-4569-99b2-6dcc8cf92f33.pdf";
        await DownloadPdfService()
            .download(baseUrl, 'sample.pdf')
            .then((value) {
          docUrl = value;
        });
        Printing.directPrintPdf(
          // printer: Printer(url: printUrl, name: printSelected),
          printer: Printer(url: dataPrinter[1].name),
          onLayout: (PdfPageFormat format) async => docUrl,
        );

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfPreviewPage(data: docUrl),
          ),
        );

        cSnackbar(context);
        log('status print : success');
      } catch (e) {
        cSnackbar(context, isSuccess: false);
        log('status print : failed $e');
      }
    } else {
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save(),
      );
    }
  }

  void cSnackbar(BuildContext context, {bool isSuccess = true}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isSuccess ? 'Success' : 'Failed'),
        backgroundColor: isSuccess ? Colors.green : Colors.red));
  }

  void printerQueue() async {
    Printing.info().then((value) {
      log('printing info : $value');
    });
  }

  Future<File> downloadPdf() async {
    Dio dio = Dio();
    String baseUrl =
        "https://s3.ap-southeast-1.amazonaws.com/kelola/shopee/label-market/48e432f1-d762-4569-99b2-6dcc8cf92f33.pdf";
    var result = await dio.get(baseUrl);
    // log('success download pdf ${result.data}');
    final path = await FilePicker.platform.saveFile(fileName: 'suragch.pdf');
    if (path == null) return File('');
    final saveFile = File(path);
    await saveFile.writeAsBytes(result.data);

    return saveFile;
  }
}
