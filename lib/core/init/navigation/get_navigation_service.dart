import 'package:get/get.dart';
import 'package:sprinkler_app/core/init/navigation/inavigation_service.dart';

class GetNavigationService implements INavgiationService {
  GetNavigationService._init();

  static GetNavigationService? _instance;

  static GetNavigationService get instance {
    _instance ??= GetNavigationService._init();

    return _instance!;
  }

  @override
  Future<void> navigateToPage({required String path, Object? data}) async {
    await Get.toNamed(path, arguments: data);
  }

  @override
  Future<void> navigateToPageClear({required String path, Object? data}) async {
    await Get.offAndToNamed(path, arguments: data);
  }
}
