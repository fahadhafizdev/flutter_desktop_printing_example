import 'package:flutter/material.dart';
import 'package:flutter_printer/app/modules/home/components/request/card_request.dart';
import 'package:flutter_printer/app/utils/extension/app_log.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final data;
  const PdfPreviewPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
      ),
      body: PdfPreview(
        build: (format) {
          logSys('$data', title: 'PRINTER');
          return data;
        },

        // useActions: false,
        onPrinted: (context) {
          logSys(title: 'PRINTED SUCCESS', 'success print');
        },
        onPrintError: (context, error) {
          logSys(title: 'PRINTED ERROR', error.toString());
        },
      ),
    );
  }
}
