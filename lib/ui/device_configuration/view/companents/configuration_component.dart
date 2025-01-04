import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ConfigurationComponent extends StatefulWidget {
  const ConfigurationComponent({
    super.key,
    this.maxValue = 50,
    this.minValue = -20,
    required this.text,
  });

  final double minValue;
  final double maxValue;
  final String text;

  @override
  State<ConfigurationComponent> createState() => _ConfigurationComponentState();
}

class _ConfigurationComponentState extends State<ConfigurationComponent> {
  late double lowerValue;
  late double upperValue;

  @override
  void initState() {
    super.initState();
    lowerValue = 0;
    upperValue = 10;
  }

  Color getTemperatureColor(double value) {
    if (value <= widget.minValue + 10) return Colors.blue;
    if (value >= widget.maxValue - 10) return Colors.red;
    return Colors.orange;
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
                  child: Container(
                    width: 40,
                    height: constraints.maxHeight - 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: constraints.maxHeight - 40,
                    child: SfLinearGauge(
                      orientation: LinearGaugeOrientation.vertical,
                      minimum: widget.minValue,
                      maximum: widget.maxValue,
                      interval: 10,
                      showLabels: true,
                      labelPosition: LinearLabelPosition.outside,
                      labelFormatterCallback: (label) => '$label°C',
                      markerPointers: [
                        LinearShapePointer(
                          value: lowerValue,
                          color: getTemperatureColor(lowerValue),
                          onChanged: (val) {
                            if (val < upperValue) {
                              setState(() => lowerValue = val);
                            }
                          },
                          shapeType: LinearShapePointerType.circle,
                          position: LinearElementPosition.cross,
                          width: 20,
                          height: 20,
                        ),
                        LinearShapePointer(
                          value: upperValue,
                          color: getTemperatureColor(upperValue),
                          onChanged: (val) {
                            if (val > lowerValue) {
                              setState(() => upperValue = val);
                            }
                          },
                          shapeType: LinearShapePointerType.circle,
                          position: LinearElementPosition.cross,
                          width: 20,
                          height: 20,
                        ),
                      ],
                      ranges: [
                        LinearGaugeRange(
                          startValue: lowerValue,
                          endValue: upperValue,
                          color: Colors.orange.withOpacity(0.3),
                          position: LinearElementPosition.cross,
                          // thickness: 40,
                        ),
                      ],
                    ),
                  ),
                ),

                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     width: 40,
                //     height: 40,
                //     decoration: BoxDecoration(
                //       color: Colors.grey[200],
                //       shape: BoxShape.circle,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '${widget.text}\n Seçili Aralık: ${lowerValue.toStringAsFixed(1)}°C - ${upperValue.toStringAsFixed(1)}°C',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
