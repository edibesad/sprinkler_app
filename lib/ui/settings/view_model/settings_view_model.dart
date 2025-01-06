import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/services/shared_preferences_service.dart';
import 'package:sprinkler_app/ui/home/view_model/home_view_model.dart';

import '../../../core/base/model/base_view_model.dart';

class SettingsViewModel extends BaseViewModel {
  Rx<TextEditingController> serverAddressController =
      Rx<TextEditingController>(TextEditingController());

  RxBool isLocal = false.obs;

  @override
  void init() {
    if (appViewModel.host != null) {
      serverAddressController.value.text = appViewModel.host!;
    }
    isLocal(appViewModel.isLocal);
  }

  @override
  void dispose() {
    super.dispose();
    serverAddressController.value.dispose();
  }

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  void exitApp() {
    exit(0);
  }

  void saveServerAddress() async {
    final homeViewModel = Get.find<HomeViewModel>();
    if (homeViewModel.isLoading.value) {
      Get.showSnackbar(const GetSnackBar(
        message: "Bağlantı kurulurken işlem yapılamaz",
        duration: Duration(seconds: 2),
      ));
      return;
    }

    if (serverAddressController.value.text.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: "Sunucu adresi boş olamaz",
        duration: Duration(seconds: 2),
      ));
      return;
    }

    if (!serverAddressController.value.text.startsWith("ws://") &&
        !serverAddressController.value.text.startsWith("wss://")) {
      Get.showSnackbar(const GetSnackBar(
        message: "Geçerli bir sunucu adresi giriniz",
        duration: Duration(seconds: 2),
      ));
      return;
    }

    SharedPreferencesService.instance
        .setStringValue("host", serverAddressController.value.text);
    appViewModel.host = serverAddressController.value.text;

    serverAddressController.refresh();

    await homeViewModel.disconnectSocket();
    homeViewModel.connectToSocket();
  }

  void connectionTypeOnChanged(bool value) {
    isLocal(value);
    appViewModel.isLocal = value;
    SharedPreferencesService.instance.setBoolValue("isLocal", value);
  }

  onServerAddressCancel() {
    serverAddressController.value.text = appViewModel.host!;
  }
}
