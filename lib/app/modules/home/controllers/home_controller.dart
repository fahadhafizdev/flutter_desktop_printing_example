import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_printer/app/config/config.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_window_close/flutter_window_close.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

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

  List<String> dataPrinter = ['none'];
  RxString printerSelected = 'none'.obs;
  RxBool loadPrinter = false.obs;

  Future<void> getPrinters() async {
    late List<Printer> listData;
    await Printing.listPrinters().then((value) {
      listData = value;

      logSys('printer added ${dataPrinter.length}');
    });

    for (var element in listData) {
      dataPrinter.add(element.name);
      addLog(LogModel(
          title: 'SUCCESS',
          status: 'success add printer ${element.name} to list printer'));
      refreshPrinter();
    }
  }

  void refreshPrinter() {
    loadPrinter(true);
    loadPrinter(false);
  }

  List<String> dataPaper = ['A3', 'A4'];
  RxString paperSelected = 'none'.obs;

  //----------FLOW LOGOUT--------------
  void logout() {
    CustomService().request(
      title: 'logout service :',
      url: '$baseUrl/auth/logout',
      method: Method.DELETE,
      withToken: true,
    );
    SharedPrefferenceService().clear();
    cli.dispose();
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
    if (printerSelected.value == 'none') return;
    await DownloadPdfService()
        .download(newData.url, newData.title)
        .then((value) {
      newData.docUrl = value;
    });

    listRequest.add(newData);
    addLog(
      LogModel(
          title: 'SUCCESS',
          status: 'Success add pdf to queue (${newData.title})'),
    );

    //jika donlodable = true --> bisa print
    if (newData.downlodable) {
      await printRequest(newData);
    }
    await Future.delayed(const Duration(seconds: 1));
    scrollDown2();
    scrollDown();
  }

  Future<void> printRequest(RequestModel newData) async {
    Printing.directPrintPdf(
      printer: Printer(url: printerSelected.value),
      onLayout: (PdfPageFormat format) async => newData.docUrl,
      format: PdfPageFormat.a6,
    );
    addLog(
      LogModel(title: 'SUCCESS', status: 'pdf is printing (${newData.title})'),
    );
    scrollDown2();
    scrollDown();
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

  ScrollController scrollCtx2 = ScrollController();
  Future<void> scrollDown2() async {
    if (scrollCtx2.hasClients) {
      scrollCtx2.animateTo(
        scrollCtx2.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void addLog(LogModel data) async {
    logRequest.add(data);
    await scrollDown();
    await scrollDown();
  }
  //----------END REQUEST PDF----------

  //------FLOW SOCKET----------
  late PubSubService cli;
  Future<void> initSocket() async {
    cli = PubSubService();
    logSys('init socket in home', title: 'SOCKET_IO');

    await getProfile();
    await cli.init();
    await cli.connect();
    await cli.subscribe();
  }

  //FLOW CLOSE KEYBOARD
  var alertShowing = false;
  var index = 0;

  void initCloseWindows() async {
    FlutterWindowClose.setWindowShouldCloseHandler(() async {
      if (index == 0) {
        if (alertShowing) return false;
        alertShowing = true;

        return await showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                  title: Text(
                    'Do you really want to quit?',
                    style: AppFont.interBlack1.copyWith(
                      fontWeight: AppFont.semiBold,
                      fontSize: 15,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        alertShowing = false;
                      },
                      child: Text(
                        'Yes',
                        style: AppFont.interBlack1,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                          alertShowing = false;
                        },
                        child: Text(
                          'No',
                          style: AppFont.interBlack1,
                        ))
                  ]);
            });
      } else if (index == 1) {
        final result = await FlutterPlatformAlert.showCustomAlert(
          windowTitle: "Really?",
          text: "Do you really want to quit?",
          positiveButtonTitle: "Quit",
          negativeButtonTitle: "Cancel",
        );
        return result == CustomButton.positiveButton;
      } else if (index == 3) {
        return await Future.delayed(const Duration(seconds: 1), () => true);
      }
      return true;
    });
  }
}
