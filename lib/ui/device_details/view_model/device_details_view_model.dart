import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/app/model/incoming_data.dart';
import 'package:sprinkler_app/core/base/model/base_view_model.dart';
import 'package:sprinkler_app/core/services/web_socket_service.dart';

import '../../device_configuration/view/device_configuration_view.dart';

class DeviceDetailsViewModel extends BaseViewModel {
  late Rx<IncomingData> data;
  late StreamSubscription<String> subscription;
  int hour = 0;
  int minute = 0;

  late AnimationController animationController;

  @override
  void init() {
    data = (Get.arguments as IncomingData).obs;
    data.listen(listenData);
    subscription = WebSocketService.instance.getMessages.listen(listenMessages);
  }

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  void listenMessages(String message) {
    try {
      final List jsonList = jsonDecode(message);

      final list =
          jsonList.map((element) => IncomingData.fromJson(element)).toList();

      data.value = list.firstWhere(
        (element) => element.id == data.value.id,
      );
      if (data.value.work != 0) {
        animationController.repeat();
      } else {
        animationController.reset();
        animationController.stop();
      }
    } catch (e) {
      if (kDebugMode) {
        printError(info: "Hata Kodu LS Hata: $e");
      }
    }
  }

  void listenData(IncomingData data) {
    hour = (data.work ?? 0) ~/ 3600;
    minute = ((data.work ?? 0) % 3600) ~/ 60;
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void goToConfiguration() {
    Get.to(() => const DeviceConfigurationView(), arguments: data.value);
  }

  void cancelWork() {
    WebSocketService.instance
        .sendMessage((data.value..configurationWork = 0).toJson().toString());
  }
}
