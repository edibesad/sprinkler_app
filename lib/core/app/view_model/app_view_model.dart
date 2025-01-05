import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/base/model/base_view_model.dart';
import 'package:sprinkler_app/core/services/shared_preferences_service.dart';

class AppViewModel extends BaseViewModel {
  String? host;
  bool isLocal = false;

  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  late Socket socket;
  late Stream<Uint8List> socketStream;
  SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService.instance;

  @override
  Future<void> init() async {
    host = await sharedPreferencesService.getStringValue("host");
    isLocal = await sharedPreferencesService.getBoolValue("isLocal") ?? false;
  }

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }
}
