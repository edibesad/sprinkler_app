import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprinkler_app/core/app/model/incoming_data.dart';
import 'package:sprinkler_app/core/extension/context_extension.dart';
import 'package:sprinkler_app/ui/device_details/view/device_details.dart';
import 'package:sprinkler_app/ui/home/view/components/humidity_widget.dart';
import 'package:sprinkler_app/ui/home/view/components/thermometer_widget.dart';

import '../../../device_details/view/components/history.dart';

class DevicesListElement extends StatelessWidget {
  const DevicesListElement(this.data, {super.key});

  final IncomingData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const DeviceDetails(), arguments: data);
      },
      child: Card(
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  data.sensorId.toString(),
                  style: GoogleFonts.nunito(
                      fontSize: context.highValue * 0.5,
                      color: const Color.fromRGBO(16, 38, 148, 20)),
                ),
                Expanded(
                  child: CarouselSlider(
                    disableGesture: true,
                    items: [
                      Center(
                        child: Text(
                          "Kalan Süre \n${((data.work ?? 0) ~/ 3600).toString()} saat ${(((data.work ?? 0) % 3600) ~/ 60).toString()} dakika",
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ThermometerWidget(
                          mac: data.macId!,
                          sensorId: data.sensorId!,
                          yValue: YValue.temperature,
                          showHistoryButton: false,
                          text: "Sıcaklık (°C)",
                          currentTemperature: data.airTemp!.toDouble()),
                      ThermometerWidget(
                          mac: data.macId!,
                          sensorId: data.sensorId!,
                          yValue: YValue.dirtTemperature,
                          showHistoryButton: false,
                          text: "Toprak Sıcaklığı (°C)",
                          currentTemperature: data.dirtTemp!.toDouble()),
                      HumidityWidget(
                        mac: data.macId!,
                        sensorId: data.sensorId!,
                        yValue: YValue.humidity,
                        value: data.airHumidity!.toDouble(),
                        text: "Hava Nem",
                        showHistoryButton: false,
                      ),
                      HumidityWidget(
                        value: data.dirtHumidity!.toDouble(),
                        mac: data.macId!,
                        sensorId: data.sensorId!,
                        yValue: YValue.dirtHumidity,
                        text: "Toprak Nem",
                        showHistoryButton: false,
                      ),
                    ],
                    options: CarouselOptions(
                        // height: context.height / 2,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
