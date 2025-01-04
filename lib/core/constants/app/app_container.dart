import 'package:sprinkler_app/core/app/view_model/app_view_model.dart';

class AppContainer {
  AppContainer._init();
  static AppContainer? _instance;
  static AppContainer get instance {
    _instance ??= AppContainer._init();
    return _instance!;
  }

  late AppViewModel appViewModel;
}
