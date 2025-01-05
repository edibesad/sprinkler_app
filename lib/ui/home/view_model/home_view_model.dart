import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/app/model/incoming_data.dart';
import 'package:sprinkler_app/core/base/model/base_view_model.dart';
import 'package:sprinkler_app/core/services/web_socket_service.dart';

import '../../settings/view/settings_view.dart';

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
  void dispose() {
    super.dispose();
    disconnectSocket();
  }

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  Future<void> connectToSocket() async {
    try {
      isLoading(true);
      await getHost();
      await WebSocketService.instance.connectToSocket(appViewModel.host!);
      subscribeToMessages();
      error.value = null;
    } catch (e) {
      error.value = e.toString();
      if (kDebugMode) {
        printError(info: "Hata Kodu: CTS Hata: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> disconnectSocket() async {
    try {
      isLoading(true);
      WebSocketService.instance.disconnect();
      error.value = null;
    } catch (e) {
      error.value = e.toString();
      if (kDebugMode) {
        printError(info: "Hata Kodu: DS Hata: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getHost() async {
    appViewModel.host =
        await appViewModel.sharedPreferencesService.getStringValue('host');

    if (appViewModel.host == null) {
      throw "Bağlantı Adresi Bulunamadı";
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

      // incomingData.value =
      //     jsonList.map((element) => IncomingData.fromJson(element)).toList();

      final newList =
          jsonList.map((element) => IncomingData.fromJson(element)).toList();

      for (var i = 0; i < incomingData.length; i++) {
        for (var j = 0; j < newList.length; j++) {
          if (newList[j].id == incomingData[i].id) {
            incomingData[i] = newList[j];
            newList.removeAt(j);
            break;
          }
        }
      }

      incomingData.addAll(newList);

      incomingData.refresh();
    } catch (e) {
      incomingData.clear();
      if (kDebugMode) {
        printError(info: "Hata Kodu LS Hata: $e");
      }
    }
  }

  void toSettings() {
    Get.to(() => const SettingsView());
  }
}
