import 'package:flutter/material.dart';
import 'package:sprinkler_app/core/components/flip_animation.dart';
import 'package:sprinkler_app/ui/device_details/view/components/history.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ThermometerWidget extends StatefulWidget {
  final double currentTemperature;
  final double minTemperature;
  final double maxTemperature;
  final String text;
  final bool showHistoryButton;
  final YValue yValue;
  final int sensorId;
  final String mac;

  const ThermometerWidget({
    super.key,
    required this.text,
    required this.currentTemperature,
    required this.yValue,
    required this.sensorId,
    required this.mac,
    this.minTemperature = -20,
    this.maxTemperature = 50,
    this.showHistoryButton = true,
  });

  @override
  State<ThermometerWidget> createState() => _ThermometerWidgetState();
}

class _ThermometerWidgetState extends State<ThermometerWidget> {
  bool _flipped = false;

  late void Function() _animateForward;
  late void Function() _animateReverse;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                    children: [
                      Positioned.fill(
                        child: FlipAnimation(
                            onInit: (forward, reverse) {
                              _animateForward = forward;
                              _animateReverse = reverse;
                            },
                            firstChild: buildTemperature(constraints),
                            secondChild: History(
                              minimum: widget.minTemperature.toInt(),
                              maximum: widget.maxTemperature.toInt(),
                              mac: widget.mac,
                              yValue: widget.yValue,
                              sensorId: widget.sensorId,
                            )),
                      ),
                      if (widget.showHistoryButton)
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(Icons.history),
                            onPressed: () {
                              if (_flipped) {
                                _animateReverse();
                                _flipped = false;
                              } else {
                                _animateForward();
                                _flipped = true;
                              }
                            },
                          ),
                        )
                    ],
                  )),
        ),
        Text(
          widget.text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  SizedBox buildTemperature(BoxConstraints constraints) {
    return SizedBox(
      height: constraints.maxHeight,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Civa haznesi (bulb)
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: constraints.maxHeight - 20,
              child: SfLinearGauge(
                minimum: widget.minTemperature,
                maximum: widget.maxTemperature,
                orientation: LinearGaugeOrientation.vertical,
                axisTrackStyle: const LinearAxisTrackStyle(
                  edgeStyle: LinearEdgeStyle.endCurve,
                  thickness: 20,
                  color: Colors.grey,
                ),
                barPointers: [
                  LinearBarPointer(
                    value: widget.currentTemperature,
                    thickness: 20,
                    color: _getTemperatureColor(widget.currentTemperature),
                    edgeStyle: LinearEdgeStyle.bothCurve,
                  ),
                ],
                markerPointers: [
                  LinearWidgetPointer(
                    value: widget.currentTemperature,
                    position: LinearElementPosition.cross,
                    child: Container(
                      height: 25,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: Colors.grey),
                      ),
                      child: Center(
                        child: Text(
                          '${widget.currentTemperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                ranges: [
                  LinearGaugeRange(
                    startValue: widget.minTemperature,
                    endValue: widget.maxTemperature,
                    startWidth: 20,
                    endWidth: 20,
                    color: Colors.transparent,
                  ),
                ],
                majorTickStyle: const LinearTickStyle(length: 20),
                minorTickStyle: const LinearTickStyle(length: 10),
                interval: 10,
                minorTicksPerInterval: 4,
              ),
            ),
          ),
          // Termometre gövdesi
          Positioned(
            bottom: 0,
            left: (constraints.maxWidth / 2) - 30,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getTemperatureColor(widget.currentTemperature),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTemperatureColor(double temperature) {
    if (temperature < 0) {
      return Colors.blue;
    } else if (temperature < 15) {
      return Colors.lightBlue;
    } else if (temperature < 25) {
      return Colors.green;
    } else if (temperature < 35) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
