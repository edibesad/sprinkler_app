import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/app/model/incoming_data.dart';
import 'package:sprinkler_app/core/base/model/base_view_model.dart';
import 'package:sprinkler_app/core/services/web_socket_service.dart';

class HomeViewModel extends BaseViewModel {
  RxBool isLoading = true.obs;

  RxList<IncomingData> incomingData = RxList.empty();

  RxnString error = RxnString();

  late WebSocket webSocket;

  @override
  Future<void> init() async {
    connectToSocket();
  }

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  Future<void> connectToSocket() async {
    try {
      isLoading(true);
      await WebSocketService.instance.connectToSocket(
          appViewModel.host, appViewModel.port,
          sourceAddress: "ws");
      subscribeToMessages();
    } catch (e) {
      error.value = e.toString();
      if (kDebugMode) {
        printError(info: "Hata Kodu: CTS Hata: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> subscribeToMessages() async {
    try {
      isLoading(true);
      WebSocketService.instance.getMessages.listen(listenSocket);
    } catch (e) {
      error.value = e.toString();
      if (kDebugMode) {
        printError(info: "Hata Kodu: STM Hata: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  void listenSocket(String data) {
    try {
      final List jsonList = jsonDecode(data);

      incomingData.value =
          jsonList.map((element) => IncomingData.fromJson(element)).toList();

      incomingData.refresh();
    } catch (e) {
      incomingData.clear();
      if (kDebugMode) {
        printError(info: "Hata Kodu LS Hata: $e");
      }
    }
  }
}
