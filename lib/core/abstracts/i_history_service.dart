import 'package:sprinkler_app/core/app/model/incoming_data.dart';

abstract class IHistoryService {
  Future<List<IncomingData>> getAllHistory({String? macId, int? sensorId});
  Future<List<IncomingData>> getHistoryByRange(
      {DateTime? startDate, DateTime? endDate, String? macId, int? sensorId});
  Future<List<IncomingData>> getDailyHistory({String? macId, int? sensorId});
  Future<List<IncomingData>> getWeeklyHistory({String? macId, int? sensorId});
  Future<List<IncomingData>> getMonthlyHistory({String? macId, int? sensorId});
  Future<List<IncomingData>> getYearlyHistory({String? macId, int? sensorId});
}
