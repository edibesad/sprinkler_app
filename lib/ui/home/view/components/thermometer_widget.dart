import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ThermometerWidget extends StatefulWidget {
  final double currentTemperature;
  final double minTemperature;
  final double maxTemperature;
  final String text;

  const ThermometerWidget({
    super.key,
    required this.text,
    required this.currentTemperature,
    this.minTemperature = -20,
    this.maxTemperature = 50,
  });

  @override
  State<ThermometerWidget> createState() => _ThermometerWidgetState();
}

class _ThermometerWidgetState extends State<ThermometerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
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
                                  color: _getTemperatureColor(
                                      widget.currentTemperature),
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
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
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
                              color: _getTemperatureColor(
                                  widget.currentTemperature),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
        ),
        Text(
          widget.text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        )
      ],
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
