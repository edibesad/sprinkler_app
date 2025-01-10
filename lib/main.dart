import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sprinkler_app/core/app/view_model/app_view_model.dart';
import 'package:sprinkler_app/core/base/view/base_view.dart';
import 'package:sprinkler_app/core/utils/constants/app/app_container.dart';
import 'package:sprinkler_app/core/utils/theme/themes.dart';

import 'ui/home/view/home_view.dart';

Future<void> main() async {
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
          return const GetMaterialApp(
              // theme: Themes.customTheme,
              themeMode: ThemeMode.light,
              home: HomeView());
        });
      },
    );
  }
}
