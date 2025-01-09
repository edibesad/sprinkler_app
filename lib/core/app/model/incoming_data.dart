import 'package:json_annotation/json_annotation.dart';

import '../../base/model/base_model.dart';

part 'incoming_data.g.dart';

@JsonSerializable(explicitToJson: true)
class IncomingData extends BaseModel {
  int? id;
  String? macId;
  int? dirtTemp;
  int? dirtHumidity;
  int? airHumidity;
  int? airTemp;

  int? work;

  int? configurationWork;
  DateTime? createDate;
  int? minDirtHumidity;
  int? maxDirtHumidity;
  int? minDirtTemp;
  int? maxDirtTemp;
  int? minAirHumidity;
  int? maxAirHumidity;
  int? minAirTemp;
  int? maxAirTemp;
  int? sensorId;

  IncomingData(
      {this.id,
      this.macId,
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
      this.minDirtTemp,
      this.sensorId,
      this.createDate});

  factory IncomingData.fromJson(Map<String, dynamic> json) =>
      _$IncomingDataFromJson(json);

  @override
  fromJson(Map<String, dynamic> json) => _$IncomingDataFromJson(json);

  @override
  Map<String, Object?> toJson() => _$IncomingDataToJson(this);
}
