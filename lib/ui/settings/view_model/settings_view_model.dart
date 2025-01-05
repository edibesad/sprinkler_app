import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/services/shared_preferences_service.dart';
import 'package:sprinkler_app/ui/home/view_model/home_view_model.dart';

import '../../../core/base/model/base_view_model.dart';

class SettingsViewModel extends BaseViewModel {
  TextEditingController serverAddressController = TextEditingController();

  RxBool isLocal = false.obs;

  @override
  void init() {
    if (appViewModel.host != null) {
      serverAddressController.text = appViewModel.host!;
    }
    isLocal(appViewModel.isLocal);
  }

  @override
  void dispose() {
    super.dispose();
    serverAddressController.dispose();
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

    SharedPreferencesService.instance
        .setStringValue("host", serverAddressController.text);
    appViewModel.host = serverAddressController.text;
    await homeViewModel.disconnectSocket();
    homeViewModel.connectToSocket();
  }

  void connectionTypeOnChanged(bool value) {
    isLocal(value);
    appViewModel.isLocal = value;
    SharedPreferencesService.instance.setBoolValue("isLocal", value);
  }

  onServerAddressCancel() {
    serverAddressController.text = appViewModel.host!;
  }
}
