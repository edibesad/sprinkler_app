import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ConfigurationTemperature extends StatefulWidget {
  const ConfigurationTemperature(
      {super.key,
      this.minimum = 0,
      this.maximum = 100,
      this.initLowerValue,
      this.initUpperValue,
      this.onChanged,
      this.text = "Sıcaklık"});
  final double minimum;
  final double maximum;
  final double? initLowerValue;
  final double? initUpperValue;
  final String text;
  final Function(double lowerValue, double upperValue)? onChanged;

  @override
  State<ConfigurationTemperature> createState() =>
      _ConfigurationTemperatureState();
}

class _ConfigurationTemperatureState extends State<ConfigurationTemperature> {
  late double lowerValue;
  late double upperValue;

  @override
  void initState() {
    super.initState();
    lowerValue = widget.initLowerValue ?? widget.minimum;
    upperValue = widget.initUpperValue ?? widget.maximum;
  }

  Color getTemperatureColor(double value) {
    if (value <= widget.minimum + 10) return Colors.blue;
    if (value >= widget.maximum - 10) return Colors.red;
    return Colors.orange;
  }

  Color _getTemperatureColor(double value) {
    if (value <= widget.minimum + 10) return Colors.blue;
    if (value >= widget.maximum - 10) return Colors.red;
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
                      minimum: widget.minimum,
                      maximum: widget.maximum,
                      interval: 10,
                      showLabels: true,
                      labelPosition: LinearLabelPosition.outside,
                      labelFormatterCallback: (label) => '$label°C',
                      markerPointers: [
                        LinearShapePointer(
                          value: lowerValue,
                          color: _getTemperatureColor(lowerValue),
                          onChanged: (val) {
                            if (val < upperValue) {
                              setState(() => lowerValue = val.floorToDouble());
                              widget.onChanged?.call(lowerValue, upperValue);
                            }
                          },
                          shapeType: LinearShapePointerType.circle,
                          position: LinearElementPosition.cross,
                          width: 20,
                          height: 20,
                        ),
                        LinearShapePointer(
                          value: upperValue,
                          color: _getTemperatureColor(upperValue),
                          onChanged: (val) {
                            if (val > lowerValue) {
                              setState(() => upperValue = val.floorToDouble());
                              widget.onChanged?.call(lowerValue, upperValue);
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
                          color: Colors.grey,
                          position: LinearElementPosition.cross,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '${widget.text}\n Seçili Aralık: ${lowerValue.toStringAsFixed(0)}°C - ${upperValue.toStringAsFixed(0)}°C',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
