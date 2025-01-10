import 'package:flutter/material.dart';
import 'package:sprinkler_app/core/components/flip_animation.dart';
import 'package:sprinkler_app/ui/home/view/components/animated_odometer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../device_details/view/components/history.dart';

class HumidityWidget extends StatefulWidget {
  const HumidityWidget(
      {super.key,
      required this.value,
      required this.text,
      required this.yValue,
      required this.sensorId,
      required this.mac,
      this.showHistoryButton = true});
  final double value;
  final String text;
  final bool showHistoryButton;
  final YValue yValue;
  final int sensorId;
  final String mac;

  @override
  State<HumidityWidget> createState() => _HumidityWidgetState();
}

class _HumidityWidgetState extends State<HumidityWidget> {
  bool _flipped = false;

  late void Function() _animateForward;
  late void Function() _animateReverse;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned.fill(
              child: FlipAnimation(
                  onInit: (forward, reverse) {
                    _animateForward = forward;
                    _animateReverse = reverse;
                  },
                  firstChild: buildRadialGauge(constraints),
                  secondChild: History(
                      minimum: 0,
                      maximum: 100,
                      mac: widget.mac,
                      sensorId: widget.sensorId,
                      yValue: widget.yValue))),
          if (widget.showHistoryButton)
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      if (_flipped) {
                        _animateReverse();
                        _flipped = false;
                      } else {
                        _animateForward();
                        _flipped = true;
                      }
                    },
                    icon: const Icon(Icons.history))),
        ],
      );
    });
  }

  Column buildRadialGauge(BoxConstraints constraints) {
    return Column(
      children: [
        Expanded(
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
              annotations: [
                GaugeAnnotation(
                    positionFactor: .4,
                    angle: 90,
                    widget: AnimatedOdometer(
                      value: widget.value.toInt(),
                      digitWidth: constraints.maxWidth * .04,
                      digitHeight: constraints.maxHeight * .07,
                      numberOfDigits: 3,
                    ))
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                    enableAnimation: true,
                    animationType: AnimationType.ease,
                    value: widget.value,
                    needleColor: Colors.black,
                    tailStyle: const TailStyle(
                        length: 0.18,
                        width: 8,
                        color: Colors.black,
                        lengthUnit: GaugeSizeUnit.factor),
                    needleLength: 0.68,
                    needleStartWidth: 1,
                    needleEndWidth: 8,
                    knobStyle: const KnobStyle(
                        knobRadius: 0.07,
                        color: Colors.white,
                        borderWidth: 0.05,
                        borderColor: Colors.black),
                    lengthUnit: GaugeSizeUnit.factor)
              ],
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 100,
                    startWidth: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    endWidth: 0.1,
                    gradient: const SweepGradient(stops: [
                      0.4,
                      0.6
                    ], colors: <Color>[
                      Color.fromARGB(255, 180, 126, 107),
                      Colors.lightBlue
                    ]))
              ],
              ticksPosition: ElementsPosition.outside,
              labelsPosition: ElementsPosition.outside,
              minorTicksPerInterval: 5,
              axisLineStyle: const AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor,
                thickness: 0.1,
              ),
              axisLabelStyle: const GaugeTextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),
              radiusFactor: 0.97,
              majorTickStyle: const MajorTickStyle(
                  length: 0.1, thickness: 2, lengthUnit: GaugeSizeUnit.factor),
              minorTickStyle: const MinorTickStyle(
                  length: 0.05,
                  thickness: 1.5,
                  lengthUnit: GaugeSizeUnit.factor),
              minimum: 0,
              maximum: 100,
              interval: 5,
              startAngle: 115,
              endAngle: 65,
            ),
          ]),
        ),
        Text(
          "${widget.text} (%)",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
