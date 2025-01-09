import 'package:sprinkler_app/core/abstracts/i_history_service.dart';
import 'package:sprinkler_app/core/app/view_model/app_view_model.dart';
import 'package:sprinkler_app/core/services/history_service.dart';
import 'package:sprinkler_app/core/services/http_service.dart';
import 'package:sprinkler_app/core/services/shared_preferences_service.dart';

class AppContainer {
  AppContainer._init();
  static AppContainer? _instance;
  static AppContainer get instance {
    _instance ??= AppContainer._init();
    return _instance!;
  }

  late AppViewModel appViewModel;
  SharedPreferencesService get sharedPreferencesService =>
      SharedPreferencesService.instance;

  IHistoryService get historyService =>
      HistoryService(HttpService(appViewModel.host!));
}
