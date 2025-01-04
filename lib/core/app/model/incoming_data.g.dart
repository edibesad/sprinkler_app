// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incoming_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomingData _$IncomingDataFromJson(Map<String, dynamic> json) => IncomingData()
  ..id = (json['id'] as num?)?.toInt()
  ..mac = json['mac'] as String?
  ..dirtTemp = (json['dirt_temp'] as num?)?.toInt()
  ..dirtHumidity = (json['dirt_humidity'] as num?)?.toInt()
  ..airHumidity = (json['air_humidity'] as num?)?.toInt()
  ..airTemp = (json['air_temp'] as num?)?.toInt()
  ..work = (json['work'] as num?)?.toInt()
  ..configurationWork = (json['configuration_work'] as num?)?.toInt()
  ..minDirtHumidity = (json['min_dirt_humidity'] as num?)?.toInt()
  ..maxDirtHumidity = (json['max_dirt_humidity'] as num?)?.toInt()
  ..minDirtTemp = (json['min_dirt_temp'] as num?)?.toInt()
  ..maxDirtTemp = (json['max_dirt_temp'] as num?)?.toInt()
  ..minAirHumidity = (json['min_air_humidity'] as num?)?.toInt()
  ..maxAirHumidity = (json['max_air_humidity'] as num?)?.toInt()
  ..minAirTemp = (json['min_air_temp'] as num?)?.toInt()
  ..maxAirTemp = (json['max_air_temp'] as num?)?.toInt();

Map<String, dynamic> _$IncomingDataToJson(IncomingData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mac': instance.mac,
      'dirt_temp': instance.dirtTemp,
      'dirt_humidity': instance.dirtHumidity,
      'air_humidity': instance.airHumidity,
      'air_temp': instance.airTemp,
      'work': instance.work,
      'configuration_work': instance.configurationWork,
      'min_dirt_humidity': instance.minDirtHumidity,
      'max_dirt_humidity': instance.maxDirtHumidity,
      'min_dirt_temp': instance.minDirtTemp,
      'max_dirt_temp': instance.maxDirtTemp,
      'min_air_humidity': instance.minAirHumidity,
      'max_air_humidity': instance.maxAirHumidity,
      'min_air_temp': instance.minAirTemp,
      'max_air_temp': instance.maxAirTemp,
    };
