import 'package:json_annotation/json_annotation.dart';

import '../../base/model/base_model.dart';

part 'incoming_data.g.dart';

@JsonSerializable(explicitToJson: true)
class IncomingData extends BaseModel {
  int? id;
  String? mac;
  int? dirtTemp;
  int? dirtHumidity;
  int? airHumidity;
  int? airTemp;

  int? work;

  int? configurationWork;

  int? minDirtHumidity;
  int? maxDirtHumidity;
  int? minDirtTemp;
  int? maxDirtTemp;
  int? minAirHumidity;
  int? maxAirHumidity;
  int? minAirTemp;
  int? maxAirTemp;

  IncomingData(
      {this.id,
      this.mac,
      this.dirtTemp,
      this.dirtHumidity,
      this.airHumidity,
      this.airTemp,
      this.work,
      this.configurationWork,
      this.minDirtHumidity,
      this.maxDirtHumidity,
      this.minAirHumidity,
      this.maxAirHumidity,
      this.maxAirTemp,
      this.maxDirtTemp,
      this.minAirTemp,
      this.minDirtTemp});

  factory IncomingData.fromJson(Map<String, dynamic> json) =>
      _$IncomingDataFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$IncomingDataFromJson(json);

  @override
  Map<String, Object?> toJson() => _$IncomingDataToJson(this);
}
