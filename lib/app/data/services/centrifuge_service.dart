import 'dart:async';
import 'dart:convert';

import 'package:centrifuge/centrifuge.dart' as centrifuge;
import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/theme/app_url.dart';
import 'package:flutter_printer/app/data/models/log_model.dart';
import 'package:flutter_printer/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import 'share_preference_service.dart';

class CentrifugeService {
  late centrifuge.Client client;
  late centrifuge.Subscription subscription;
  HomeController c = Get.find();

  Future<void> init() async {
    try {
      String tokenPubSub = '';

      await SharedPrefferenceService().getTokenPubSub().then((value) {
        tokenPubSub = value ?? '';
      });

      client = centrifuge.createClient(
        centrifugeUrl,
        centrifuge.ClientConfig(token: tokenPubSub),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> connect() async {
    try {
      client.connected.listen((centrifuge.ConnectedEvent event) {
        debugPrint('centrifuge connected');
      });
      client.error.listen((centrifuge.ErrorEvent event) {
        debugPrint('centrifuge error : ${event.error}');
      });

      await client.connect();
      c.addLog(const LogModel(title: 'INFO', status: 'Socket Connected'));
    } catch (e) {
      debugPrint('centrifuge : $e');
    }
  }

  Future<void> subscribe(
      {required String channel, required Function(dynamic) callback}) async {
    debugPrint('centrifurge subscribe');

    try {
      subscription = client.newSubscription(channel);

      subscription.publication
          .map<String>((e) => utf8.decode(e.data))
          .listen((dynamic a) {
        dynamic data = jsonDecode(a);
        callback(data);
      });

      // Handle subscription async errors.
      subscription.error.listen((centrifuge.SubscriptionErrorEvent e) {
        debugPrint('centrifuge error subcribe : $e');
        c.addLog(
            const LogModel(title: 'ERROR', status: 'Failed Socket Subcribe'));
      });

      c.addLog(
          const LogModel(title: 'INFO', status: 'Success Socket Subscribe'));

      await subscription.subscribe();
    } catch (e) {
      debugPrint('centrifuge error subcribe : $e');
    }
  }

  void dispose() {
    client.disconnect();
    subscription.unsubscribe();
  }
}
