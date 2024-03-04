import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:centrifuge/centrifuge.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_printer/app/data/models/request_model.dart';
import 'package:flutter_printer/app/data/models/request_model_socket.dart';
import 'package:flutter_printer/app/data/models/user_model.dart';
import 'package:flutter_printer/app/data/services/share_preference_service.dart';
import 'package:flutter_printer/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_printer/app/utils/extension/app_log.dart';
import 'package:get/get.dart';

import 'centrifuge_service.dart';
import 'socket_io_service.dart';

class PubSubService {
  late Client client;
  late Subscription? subscription;
  CentrifugeService centrifuge = CentrifugeService();
  SocketIoService socketIo = SocketIoService();
  bool initialized = false;
  HomeController c = Get.find();

  Future<void> init() async {
    switch (dotenv.env['SOCKET_TYPE']) {
      case 'socketio':
        socketIo.init();
        initialized = true;
        break;
      case 'centrifuge':
        centrifuge.init();
        initialized = true;
        break;
      default:
    }
  }

  Future<void> connect() async {
    if (!initialized) return;
    switch (dotenv.env['SOCKET_TYPE']) {
      case 'socketio':
        socketIo.connect();
        initialized = false;
        break;
      case 'centrifuge':
        centrifuge.connect();
        initialized = false;
        break;
      default:
    }
  }

  Future<void> subscribe() async {
    UserModel? user;
    await SharedPrefferenceService().getUserModel().then((value) {
      user = UserModel.fromJson(jsonDecode(value!));
    });
    switch (dotenv.env['SOCKET_TYPE']) {
      case 'socketio':
        socketIo.subcribe(channel: 'kelola/${user!.id}/event');
        break;
      case 'centrifuge':
        centrifuge.subscribe(
            channel: 'kelola/${user!.id}/event',
            callback: (dynamic data) {
              syncRequest(data);
            });
        break;
      default:
    }
  }

  Future<void> syncRequest(dynamic data) async {
    if (data == null) return;
    logSys('centrifuge data : start sync');
    var dataRes = RequestSocketModelResponse.fromJson(data);
    Payload payload = dataRes.payload!;

    c.addRequest(
      RequestModel(
        title: payload.body!.name ?? 'undefined',
        url: payload.body!.content!,
      ),
    );
  }

  void dispose() async {
    switch (dotenv.env['SOCKET_TYPE']) {
      case 'socketio':
        socketIo.dispose();
        break;
      case 'centrifuge':
        centrifuge.dispose();
        break;
      default:
    }
  }
}
