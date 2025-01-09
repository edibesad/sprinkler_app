import 'package:get/get.dart';
import 'package:sprinkler_app/core/abstracts/i_api_service.dart';
import 'package:sprinkler_app/core/abstracts/i_history_service.dart';

import '../app/model/incoming_data.dart';

class HistoryService extends IHistoryService {
  static HistoryService? _instance;

  HistoryService._init(this.apiService);

  factory HistoryService(IApiService apiService) {
    _instance ??= HistoryService._init(apiService);
    return _instance!;
  }

  HistoryService get instance {
    if (_instance == null) {
      throw Exception('HistoryService is not initialized');
    }

    return _instance!;
  }

  IApiService apiService;

  @override
  getAllHistory({String? macId, int? sensorId}) async {
    try {
      return await getHistoryByRange(macId: macId, sensorId: sensorId);
    } catch (e) {
      Get.snackbar('HSGAH Error', e.toString());
      return <IncomingData>[];
    }
  }

  @override
  getDailyHistory({String? macId, int? sensorId}) async {
    try {
      final now = DateTime.now();
      return await getHistoryByRange(
          startDate: now.add(const Duration(days: -1)),
          endDate: now,
          macId: macId,
          sensorId: sensorId);
    } catch (e) {
      Get.snackbar('HSGDH Error', e.toString());
      return <IncomingData>[];
    }
  }

  @override
  getHistoryByRange(
      {DateTime? startDate,
      DateTime? endDate,
      String? macId,
      int? sensorId}) async {
    try {
      final response = await apiService.get(endpoint: "/sensor", query: {
        if (startDate != null) 'start_date': startDate.toIso8601String(),
        if (endDate != null) 'end_date': endDate.toIso8601String(),
        "mac_id": macId,
        "sensor_id": sensorId.toString(),
      });

      return (response.data as List)
          .map((e) => IncomingData.fromJson(e))
          .toList();
    } catch (e) {
      Get.snackbar('HSGHBR Error', e.toString());
      return <IncomingData>[];
    }
  }

  @override
  getMonthlyHistory({String? macId, int? sensorId}) async {
    try {
      final now = DateTime.now();
      return await getHistoryByRange(
          macId: macId,
          sensorId: sensorId,
          startDate: now.add(const Duration(days: -30)),
          endDate: now);
    } catch (e) {
      Get.snackbar('HSGMH Error', e.toString());
      return <IncomingData>[];
    }
  }

  @override
  getWeeklyHistory({String? macId, int? sensorId}) async {
    try {
      final now = DateTime.now();
      return await getHistoryByRange(
        startDate: now.add(const Duration(days: -7)),
        endDate: now,
        macId: macId,
        sensorId: sensorId,
      );
    } catch (e) {
      Get.snackbar('HSGWH Error', e.toString());
      return <IncomingData>[];
    }
  }

  @override
  getYearlyHistory({String? macId, int? sensorId}) async {
    try {
      final now = DateTime.now();
      return await getHistoryByRange(
        startDate: now.add(const Duration(days: -365)),
        endDate: now,
        macId: macId,
        sensorId: sensorId,
      );
    } catch (e) {
      Get.snackbar('HSGYH Error', e.toString());
      return <IncomingData>[];
    }
  }
}
