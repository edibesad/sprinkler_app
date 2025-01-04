import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/app/model/incoming_data.dart';
import 'package:sprinkler_app/core/base/model/base_view_model.dart';
import 'package:sprinkler_app/core/services/web_socket_service.dart';

class DeviceDetailsViewModel extends BaseViewModel {
  late Rx<IncomingData> data;
  late StreamSubscription<String> subscription;

  @override
  void init() {
    data = (Get.arguments as IncomingData).obs;
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
    } catch (e) {
      if (kDebugMode) {
        printError(info: "Hata Kodu LS Hata: $e");
      }
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
