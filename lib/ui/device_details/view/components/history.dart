import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprinkler_app/core/app/model/incoming_data.dart';
import 'package:sprinkler_app/core/utils/constants/app/app_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class History extends StatefulWidget {
  const History(
      {super.key,
      required this.mac,
      required this.sensorId,
      required this.yValue,
      required this.minimum,
      required this.maximum});

  final String mac;
  final int sensorId;
  final YValue yValue;
  final int minimum;
  final int maximum;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool _isLoading = false;

  List<_ChartData> _data = [];

  HistoryType selected = HistoryType.daily;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });

    switch (selected) {
      case HistoryType.daily:
        _formatToChartData(await AppContainer.instance.historyService
            .getDailyHistory(macId: widget.mac, sensorId: widget.sensorId));
        break;
      case HistoryType.weekly:
        _formatToChartData(await AppContainer.instance.historyService
            .getWeeklyHistory(macId: widget.mac, sensorId: widget.sensorId));
        break;
      case HistoryType.monthly:
        _formatToChartData(await AppContainer.instance.historyService
            .getMonthlyHistory(macId: widget.mac, sensorId: widget.sensorId));
        break;
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _formatToChartData(List<IncomingData> data) {
    _data = data.map((e) {
      late int y;
      switch (widget.yValue) {
        case YValue.temperature:
          y = e.airTemp ?? 0;
          break;
        case YValue.dirtTemperature:
          y = e.dirtTemp ?? 0;
          break;
        case YValue.humidity:
          y = e.airHumidity ?? 0;
          break;
        case YValue.dirtHumidity:
          y = e.dirtHumidity ?? 0;
          break;
      }

      return _ChartData(
        e.createDate!,
        y,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildChart()),
          SegmentedButton<HistoryType>(
              onSelectionChanged: (selections) {
                setState(() {
                  selected = selections.first;
                  getData();
                });
              },
              segments: const [
                ButtonSegment(value: HistoryType.daily, label: Text('Günlük')),
                ButtonSegment(
                    value: HistoryType.weekly, label: Text('Haftalık')),
                ButtonSegment(value: HistoryType.monthly, label: Text('Aylık')),
              ],
              selected: {
                selected
              })
        ],
      ),
    );
  }

  _buildChart() => SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat('yyyy-MM-dd HH:mm'),
        ),
        primaryYAxis: NumericAxis(
          minimum: widget.minimum.toDouble(),
          maximum: widget.maximum.toDouble(),
        ),
        series: <LineSeries<_ChartData, DateTime>>[
          LineSeries<_ChartData, DateTime>(
            dataSource: _data,
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
          ),
        ],
      );
}

class _ChartData {
  _ChartData(this.x, this.y);
  final DateTime x;
  final int? y;
}

enum HistoryType {
  daily,
  weekly,
  monthly,
}

enum YValue {
  temperature,
  dirtTemperature,
  humidity,
  dirtHumidity,
}
