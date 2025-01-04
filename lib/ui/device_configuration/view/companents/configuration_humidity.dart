import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ConfigurationHumidity extends StatefulWidget {
  const ConfigurationHumidity({
    super.key,
    this.minValue = 0,
    this.maxValue = 100,
    required this.text,
  });

  final double minValue;
  final double maxValue;
  final String text;
  @override
  State<ConfigurationHumidity> createState() => _ConfigurationHumidityState();
}

class _ConfigurationHumidityState extends State<ConfigurationHumidity> {
  double startValue = 30;
  double endValue = 70;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: constraints.maxHeight - 40,
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: widget.minValue,
                          maximum: widget.maxValue,
                          startAngle: 180,
                          endAngle: 0,
                          showLabels: true,
                          showTicks: true,
                          radiusFactor: 0.9,
                          labelFormat: '{value}%',
                          ranges: <GaugeRange>[
                            GaugeRange(
                              startValue: startValue,
                              endValue: endValue,
                              color: Colors.blue.withOpacity(0.3),
                              startWidth: 20,
                              endWidth: 20,
                            ),
                          ],
                          pointers: <GaugePointer>[
                            MarkerPointer(
                              value: startValue,
                              enableDragging: true,
                              onValueChanged: (value) {
                                setState(() {
                                  if (value < endValue) {
                                    startValue = value;
                                  }
                                });
                              },
                              color: Colors.blue,
                              markerHeight: 25,
                              markerWidth: 25,
                              markerType: MarkerType.circle,
                            ),
                            MarkerPointer(
                              value: endValue,
                              enableDragging: true,
                              onValueChanged: (value) {
                                setState(() {
                                  if (value > startValue) {
                                    endValue = value;
                                  }
                                });
                              },
                              color: Colors.blue,
                              markerHeight: 25,
                              markerWidth: 25,
                              markerType: MarkerType.circle,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Text(
                                '${widget.text}\n${startValue.toStringAsFixed(0)}% - ${endValue.toStringAsFixed(0)}%',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              angle: 90,
                              positionFactor: 0.5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
