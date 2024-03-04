import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/theme/app_url.dart';
import 'package:flutter_printer/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_printer/app/utils/extension/app_log.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:get/get.dart';

class SocketIoService {
  Socket? socket;

  HomeController c = Get.find();

  Future<void> init() async {
    try {
      debugPrint('start socket');

      socket = io(socketUrl, <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      });
      // socket = io(socketUrl);
      logSys('check socket init success');
    } catch (e) {
      logSys('check socket error connect ${e}');
      debugPrint(e.toString());
    }
  }

  Future<void> connect() async {
    try {
      socket?.connect();

      logSys('check socket connect success');
    } catch (e) {
      logSys('check socket error connect ${e}');
      debugPrint(e.toString());
    }
  }

  Future<void> subcribe({required final String channel}) async {
    logSys('check socket status connect ${socket!.connected}');
    try {
      socket?.on(channel, (data) {
        logSys(title: 'SOCKET LISTEN', 'socket listen $data');

        // debugPrint('socket listen request id : ${data['request_id']}');
        // debugPrint('socket listen status : ${data['status']}');
        // debugPrint('socket payload ${data['payload']['body']}');

        // c.updateSocket(
        //   requestId: data['request_id'],
        //   status: data['status'].toString(),
        //   payload: data['payload'],
        // );
      });

      logSys('check socket success subcribe $channel');
    } catch (e) {
      logSys('check socket error subcribe ${e}');
      debugPrint(e.toString());
    }
  }

  Future<void> dispose() async {
    socket?.close();
  }
}
