import 'package:sprinkler_app/core/app/model/response_model.dart';

abstract class IApiService {
  Future<ResponseModel<dynamic>> get(
      {Map<String, dynamic>? query, String? endpoint});
  Future<ResponseModel<dynamic>> post(dynamic data, {String? endpoint});
  Future<ResponseModel<dynamic>> put(dynamic data, {String? endpoint});
  Future<ResponseModel<dynamic>> delete(Map<String, dynamic> query,
      {String? endpoint});
}
