import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../base/model/base_model.dart';

part 'response_model.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class ResponseModel<T> extends BaseModel {
  final bool result;
  final String message;
  final T data;

  ResponseModel({
    required this.result,
    required this.message,
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json, (Object? object) => object as T);

  @override
  fromJson(Map<String, dynamic> json) => ResponseModel.fromJson(json);

  @override
  Map<String, Object?> toJson() =>
      _$ResponseModelToJson(this, (Object? object) {
        if (object == null) {
          return null;
        }
        return jsonEncode(object);
      });
}
