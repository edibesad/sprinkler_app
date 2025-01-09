import 'dart:convert';

import 'package:sprinkler_app/core/abstracts/i_api_service.dart';
import 'package:sprinkler_app/core/app/model/response_model.dart';
import 'package:http/http.dart' as http;

class HttpService extends IApiService {
  HttpService(this.url);
  String url;

  @override
  Future<ResponseModel> delete(Map<String, dynamic> query,
      {String? endpoint}) async {
    var uri = Uri.parse(url).replace(queryParameters: query);
    if (endpoint != null) {
      uri = uri.replace(path: uri.path + endpoint);
    }
    final response = await http.delete(uri);

    return ResponseModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<ResponseModel> get(
      {String? endpoint, Map<String, dynamic>? query}) async {
    var uri = Uri.parse(url)
        .replace(queryParameters: query, scheme: 'http', port: 6789);
    if (endpoint != null) {
      uri = uri.replace(path: uri.path + endpoint);
    }

    final response = await http.get(uri);

    return ResponseModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<ResponseModel> post(data, {String? endpoint}) {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> put(data, {String? endpoint}) {
    throw UnimplementedError();
  }
}
