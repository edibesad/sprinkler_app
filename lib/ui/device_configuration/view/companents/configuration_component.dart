import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ConfigurationComponent extends StatefulWidget {
  const ConfigurationComponent(
      {super.key, this.maxValue = 50, this.minValue = -20});
  final double minValue;
  final double maxValue;

  @override
  State<ConfigurationComponent> createState() => _ConfigurationComponentState();
}

class _ConfigurationComponentState extends State<ConfigurationComponent> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SfLinearGauge(
              orientation: LinearGaugeOrientation.horizontal,
              minimum: widget.minValue,
              maximum: widget.maxValue,
              markerPointers: [
                LinearWidgetPointer(value: value, child: Container()),
                LinearShapePointer(
                  value: value,
                  onChanged: (val) {
                    setState(() {
                      value = val;
                    });
                  },
                )
              ],
              // ranges: [
              //   LinearGaugeRange(
              //     color: Colors.blue,
              //     startValue: widget.minValue,
              //     endValue: (widget.maxValue + widget.minValue) / 2,
              //   ),
              //   LinearGaugeRange(
              //     color: Colors.amber,
              //     startValue: (widget.maxValue + widget.minValue) / 2,
              //     endValue: widget.maxValue,
              //   ),
              // ],
            ),
          ],
        );
      },
    );
  }
}
