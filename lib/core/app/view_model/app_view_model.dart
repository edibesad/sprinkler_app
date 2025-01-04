import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/base/model/base_view_model.dart';

class AppViewModel extends BaseViewModel {
  String host = "ws://192.168.4.1:8080/ws";
  int port = 8080;

  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  late Socket socket;
  late Stream<Uint8List> socketStream;

  @override
  void init() {}

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }
}
