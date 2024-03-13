import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_printer/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';

import 'app/data/models/log_model.dart';

class DownloadPdfService {
  Dio dio = Dio();
  bool isSuccess = false;

  Future<dynamic> download(String url, String filename) async {
    var savePath = 'Downloads/$filename';
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    HomeController c = Get.find();
    try {
      c.addLog(LogModel(
          title: 'IN_PROGRESS', status: 'waiting download pdf $filename'));
      var response = await dio.get(
        url,

        // onReceiveProgress: showDownloadProgress,
        //Received data with L
        //ist<int>
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          // receiveTimeout: 0,
        ),
      );
      log('data : ${response.data}');

      // String? outputFile = await FilePicker.platform.saveFile(
      //   dialogTitle: 'Please select an output file:',
      //   fileName: 'output-file.pdf',
      // );

      // if (outputFile == null) {
      //   // User canceled the picker
      // }

      c.addLog(
          LogModel(title: 'SUCCESS', status: 'success download pdf $filename'));

      return response.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void startDownloadManager() async {
    String baseUrl =
        "https://s3.ap-southeast-1.amazonaws.com/kelola/shopee/label-market/48e432f1-d762-4569-99b2-6dcc8cf92f33.pdf";
    download(baseUrl, 'sample.pdf');
  }

  void startDownloading(BuildContext context, final Function okCallback) async {
    String fileName = "Sample.pdf";

    String baseUrl =
        "https://s3.ap-southeast-1.amazonaws.com/kelola/shopee/label-market/48e432f1-d762-4569-99b2-6dcc8cf92f33.pdf";

    // String path = await _getFilePath(fileName);

    final Directory? dir = await getDownloadsDirectory();
    String path = "${dir?.path}";

    log('path download : $path');

    try {
      var result = await dio.get(baseUrl);
      // var result = await dio.download(
      //   baseUrl,
      //   'Downloads',
      //   onReceiveProgress: (recivedBytes, totalBytes) {
      //     okCallback(recivedBytes, totalBytes);
      //   },
      //   deleteOnError: true,

      // ).then((_) {
      //   isSuccess = true;
      //   log('success download pdf ${_.data}');
      // });
      log('success download pdf ${result.data}');
      final path = await FilePicker.platform.saveFile(fileName: 'suragch.pdf');
      if (path == null) return;
      final saveFile = File(path);

      await saveFile.writeAsBytes(result.data);
      print(path);
    } catch (e) {
      print("Exception$e");
    }

    if (isSuccess) {
      Navigator.pop(context);
    }
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    return "${dir?.path}$filename";
  }
}
