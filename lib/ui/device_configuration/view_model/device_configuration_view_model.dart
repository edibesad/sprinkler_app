import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/base/model/base_view_model.dart';
import 'package:sprinkler_app/core/services/web_socket_service.dart';

import '../../../core/app/model/incoming_data.dart';

class DeviceConfigurationViewModel extends BaseViewModel {
  late Rx<IncomingData> incomingData;

  double _minAirTemp = -40;
  double _maxAirTemp = 50;
  double _minDirtTemp = -40;
  double _maxDirtTemp = 50;
  double _minAirHumidity = 0;
  double _maxAirHumidity = 100;
  double _minDirtHumidity = 0;
  double _maxDirtHumidity = 100;
  int _hour = 0;
  int _minute = 0;

  @override
  void init() {
    if (Get.arguments is IncomingData) {
      incomingData = (Get.arguments as IncomingData).obs;
      _minAirTemp = incomingData.value.minAirTemp?.toDouble() ?? -40;
      _maxAirTemp = incomingData.value.maxAirTemp?.toDouble() ?? 50;
      _minDirtTemp = incomingData.value.minDirtTemp?.toDouble() ?? -40;
      _maxDirtTemp = incomingData.value.maxDirtTemp?.toDouble() ?? 50;
      _minAirHumidity = incomingData.value.minAirHumidity?.toDouble() ?? 0;
      _maxAirHumidity = incomingData.value.maxAirHumidity?.toDouble() ?? 100;
      _minDirtHumidity = incomingData.value.minDirtHumidity?.toDouble() ?? 0;
      _maxDirtHumidity = incomingData.value.maxDirtHumidity?.toDouble() ?? 100;
    } else {
      incomingData.value = IncomingData();
    }
  }

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  void save() {
    WebSocketService.instance.sendMessage(incomingData.toJson().toString());
  }

  void airTempCheckboxOnChanged(value) {
    if (value) {
      setTemperature(_minAirTemp, _maxAirTemp);
    } else {
      setTemperature(null, null);
    }
  }

  setTemperature(double? lowerValue, double? upperValue) {
    incomingData.value.minAirTemp = lowerValue?.toInt();
    incomingData.value.maxAirTemp = upperValue?.toInt();
    if (lowerValue != null) {
      _minAirTemp = lowerValue;
    }

    if (upperValue != null) {
      _maxAirTemp = upperValue;
    }
  }

  void dirtTempCheckboxOnChanged(value) {
    if (value) {
      setDirtTemperature(_minDirtTemp, _maxDirtTemp);
    } else {
      setDirtTemperature(null, null);
    }
  }

  void airHumidityCheckboxOnChanged(value) {
    if (value) {
      setAirHumidity(_minAirHumidity, _maxAirHumidity);
    } else {
      setAirHumidity(null, null);
    }
  }

  void dirtHumidityCheckboxOnChanged(value) {
    if (value) {
      setDirtHumidity(_minDirtHumidity, _maxDirtHumidity);
    } else {
      setDirtHumidity(null, null);
    }
  }

  setDirtTemperature(double? lowerValue, double? upperValue) {
    incomingData.value.minDirtTemp = lowerValue?.toInt();
    incomingData.value.maxDirtTemp = upperValue?.toInt();

    if (lowerValue != null) {
      _minDirtTemp = lowerValue;
    }
    if (upperValue != null) {
      _maxDirtTemp = upperValue;
    }
  }

  void setAirHumidity(double? lowerValue, double? upperValue) {
    incomingData.value.minAirHumidity = lowerValue?.toInt();
    incomingData.value.maxAirHumidity = upperValue?.toInt();

    if (lowerValue != null) {
      _minAirHumidity = lowerValue;
    }
    if (upperValue != null) {
      _maxAirHumidity = upperValue;
    }
  }

  void setDirtHumidity(double? lowerValue, double? upperValue) {
    incomingData.value.minDirtHumidity = lowerValue?.toInt();
    incomingData.value.maxDirtHumidity = upperValue?.toInt();

    if (lowerValue != null) {
      _minDirtHumidity = lowerValue;
    }
    if (upperValue != null) {
      _maxDirtHumidity = upperValue;
    }
  }

  void workCheckboxOnChanged(value) {
    if (value) {
      setWork(_hour, _minute);
    } else {
      setWork(null, null);
    }
  }

  void setWork(int? hour, int? minute) {
    if (hour == null || minute == null) {
      incomingData.value.configurationWork = null;
    } else {
      incomingData.value.configurationWork = (hour * 3600) + (minute * 60);
      _hour = hour;
      _minute = minute;
    }
  }
}
