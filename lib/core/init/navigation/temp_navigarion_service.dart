import 'package:sprinkler_app/core/init/navigation/inavigation_service.dart';

class TempNavigarionService extends INavgiationService {
  TempNavigarionService._init();

  static TempNavigarionService? _instance;

  static TempNavigarionService get instance {
    _instance ??= TempNavigarionService._init();

    return _instance!;
  }

  @override
  Future<void> navigateToPage({required String path, Object? data}) {
    // TODO: implement navigateToPage
    throw UnimplementedError();
  }

  @override
  Future<void> navigateToPageClear({required String path, Object? data}) {
    // TODO: implement navigateToPageClear
    throw UnimplementedError();
  }
}
