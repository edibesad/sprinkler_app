import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ConfigurationHumidity extends StatefulWidget {
  const ConfigurationHumidity({
    super.key,
    this.minimum = 0,
    this.maximum = 100,
    this.startValue = 30,
    this.endValue = 70,
    this.onChanged,
    required this.text,
  });

  final double minimum;
  final double maximum;
  final double startValue;
  final double endValue;
  final void Function(double lowerValue, double upperValue)? onChanged;
  final String text;
  @override
  State<ConfigurationHumidity> createState() => _ConfigurationHumidityState();
}

class _ConfigurationHumidityState extends State<ConfigurationHumidity> {
  late double startValue;
  late double endValue;

  @override
  void initState() {
    super.initState();
    startValue = widget.startValue;
    endValue = widget.endValue;
  }

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
                          minimum: widget.minimum,
                          maximum: widget.maximum,
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
                                if (value < endValue) {
                                  setState(() => (startValue = value));
                                  widget.onChanged?.call(startValue, endValue);
                                }
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
                                if (value > startValue) {
                                  setState(() => (endValue = value));
                                  widget.onChanged?.call(startValue, endValue);
                                }
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
