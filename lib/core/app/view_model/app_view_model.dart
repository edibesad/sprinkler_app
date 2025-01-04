import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/base/model/base_view_model.dart';

class AppViewModel extends BaseViewModel {
  String host = "ws://127.0.0.1:65432/ws";
  int port = 65432;

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
