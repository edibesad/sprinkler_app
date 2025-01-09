import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/app/view_model/app_view_model.dart';
import 'package:sprinkler_app/core/utils/constants/app/app_container.dart';
import 'package:sprinkler_app/core/init/navigation/get_navigation_service.dart';

import '../../init/navigation/inavigation_service.dart';

abstract class BaseViewModel extends GetxController {
  late BuildContext viewModelContext;
  AppContainer appContainer = AppContainer.instance;
  AppViewModel get appViewModel => appContainer.appViewModel;

  INavgiationService navigation = GetNavigationService.instance;
  void setContext(BuildContext context);
  void init();
}
