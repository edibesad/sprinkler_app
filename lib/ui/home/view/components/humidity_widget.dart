import 'package:flutter/material.dart';
import 'package:sprinkler_app/ui/home/view/components/animated_odometer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HumidityWidget extends StatelessWidget {
  const HumidityWidget({super.key, required this.value, required this.text});
  final double value;
  final String text;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Expanded(
            child: SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                annotations: [
                  // GaugeAnnotation(
                  //   widget: Text(
                  //     "%$value",
                  //     style: const TextStyle(
                  //         fontWeight: FontWeight.w600, fontSize: 20),
                  //   ),
                  //   angle: 90,
                  //   positionFactor: .7,
                  // )

                  GaugeAnnotation(
                      positionFactor: .4,
                      angle: 90,
                      widget: AnimatedOdometer(
                        value: value.toInt(),
                        digitWidth: 20,
                        digitHeight: 30,
                        numberOfDigits: 3,
                      ))
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                      enableAnimation: true,
                      animationType: AnimationType.ease,
                      value: value,
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
                    length: 0.1,
                    thickness: 2,
                    lengthUnit: GaugeSizeUnit.factor),
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
            "$text (%)",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )
        ],
      );
    });
  }
}
