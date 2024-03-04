import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/theme/app_url.dart';
import 'package:flutter_printer/app/data/models/log_model.dart';
import 'package:flutter_printer/app/data/models/request_model.dart';
import 'package:flutter_printer/app/data/models/user_model.dart';
import 'package:flutter_printer/app/data/services/custom_service.dart';
import 'package:flutter_printer/app/data/services/pub_sub_service.dart';
import 'package:flutter_printer/app/data/services/share_preference_service.dart';
import 'package:flutter_printer/app/utils/extension/app_log.dart';
import 'package:flutter_printer/app/utils/extension/method_enum.dart';
import 'package:flutter_printer/download_pdf_service.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeController extends GetxController {
  @override
  void onInit() {
    // initLog();
    // initSocket();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<String> dataPrinter = ['Xp-35DFG', 'HP-EGRT4', 'none'];
  RxString printerSelected = 'none'.obs;

  List<String> dataAPI = [
    'https://api.kelola.id/staff',
    'https://api-staging.kelola.id/staff',
    'none',
  ];
  RxString APISelected = 'none'.obs;

  Future<void> getPrinters() async {
    // await Printing.listPrinters().then((value) {
    //   dataPrinter.value = value;
    //   log('printer added ${dataPrinter.length}');
    // });

    // Printer xp = Printer(url: 'XP-546Z1');

    // dataPrinter.add('XP-546hI');
  }

  //----------FLOW LOGOUT--------------
  void logout() {
    CustomService().request(
      title: 'logout service :',
      url: '$baseUrl/auth/logout',
      method: Method.DELETE,
      withToken: true,
    );
    SharedPrefferenceService().clear();
    Get.offAndToNamed('/input-saas-url');
  }
  //----------END FLOW LOGOUT-----------

  //----------GET PROFILE--------------
  RxBool loadProfile = false.obs;
  UserModel userModel = UserModel(id: null);
  Future<void> getProfile() async {
    logSys(title: 'GET_PROFILE', 'get profile');
    loadProfile(true);
    try {
      var data = await CustomService().request(
        title: 'get profile :',
        url: '$baseUrl/me',
        method: Method.GET,
        withToken: true,
      );

      var dataRes = UserModelResponse.fromJson(data);

      userModel = dataRes.userModel!;
      SharedPrefferenceService().saveUserModel(userModel);

      loadProfile(false);
    } catch (e) {
      logSys(e.toString(), title: 'Error get Profile');
      loadProfile(false);
    }
  }
  //----------END GET PROFILE----------

  //----------FLOW REQUEST PDF---------
  RxList<RequestModel> listRequest = <RequestModel>[].obs;
  void addRequest(RequestModel newData) async {
    await DownloadPdfService()
        .download(newData.url, newData.title)
        .then((value) {
      newData.docUrl = value;
    });

    listRequest.add(newData);
    addLog(
        const LogModel(title: 'SUCCESS', status: 'Success add pdf to queue'));
  }

  RxList<LogModel> logRequest = <LogModel>[].obs;
  void initLog() {
    addLog(LogModel(title: 'INFO', status: 'Start Printer'));
    addLog(LogModel(title: 'INFO', status: 'Printer Version 1.0.0'));
  }

  ScrollController scrollCtx = ScrollController();
  Future<void> scrollDown() async {
    if (scrollCtx.hasClients) {
      scrollCtx.animateTo(
        scrollCtx.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void addLog(LogModel data) async {
    logRequest.add(data);
    await scrollDown();
  }
  //----------END REQUEST PDF----------

  Future<void> printPdf({required var docUrl}) async {
    Printing.directPrintPdf(
      // printer: Printer(url: printUrl, name: printSelected),
      printer: Printer(url: 'HP-345345'),
      onLayout: (PdfPageFormat format) async {
        format.printInfo(printFunction: () {});
        format.printError(logFunction: () {});
        return docUrl;
      },
      format: PdfPageFormat.a4,
    );
  }

  //------FLOW SOCKET----------
  Future<void> initSocket() async {
    logSys('init socket in home', title: 'SOCKET_IO');
    PubSubService cli = PubSubService();

    await getProfile();
    await cli.init();
    await cli.connect();
    await cli.subscribe();
  }
}
