import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/app/view_model/app_view_model.dart';
import 'package:sprinkler_app/core/base/view/base_view.dart';
import 'package:sprinkler_app/core/constants/app/app_container.dart';
import 'package:sprinkler_app/core/theme/themes.dart';
import 'package:sprinkler_app/ui/device_configuration/view/device_configuration.dart';
import 'package:sprinkler_app/ui/home/view/home_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: AppViewModel(),
      onViewModelReady: (model) {
        model.init();
        AppContainer.instance.appViewModel = model;
      },
      onPageBuild: (context, viewModel) {
        return Obx(() {
          viewModel.themeMode.value;
          return GetMaterialApp(
            theme: Themes.customTheme,
            themeMode: viewModel.themeMode.value,
            home: HomeView(),
          );
        });
      },
    );
  }
}
