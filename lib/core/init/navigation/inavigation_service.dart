abstract class INavgiationService {
  Future<void> navigateToPage(
      {required String path, Object? data}); // Bir sayfaya gider
  Future<void> navigateToPageClear(
      {required String path,
      Object? data}); // Bir sayfaya giderken diğerlerini temizler
}
