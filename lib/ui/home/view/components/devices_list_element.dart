import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprinkler_app/core/app/model/incoming_data.dart';
import 'package:sprinkler_app/core/extension/context_extension.dart';
import 'package:sprinkler_app/ui/device_details/view/device_details.dart';
import 'package:sprinkler_app/ui/home/view/components/humidity_widget.dart';
import 'package:sprinkler_app/ui/home/view/components/thermometer_widget.dart';

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
                  data.id.toString(),
                  style: GoogleFonts.nunito(
                      fontSize: context.highValue * 0.5,
                      color: const Color.fromRGBO(16, 38, 148, 20)),
                ),
                Expanded(
                  child: CarouselSlider(
                    disableGesture: true,
                    items: [
                      Hero(
                        tag: 1,
                        child: ThermometerWidget(
                            text: "Sıcaklık (°C)",
                            currentTemperature: data.airTemp!.toDouble()),
                      ),
                      ThermometerWidget(
                          text: "Toprak Sıcaklığı (°C)",
                          currentTemperature: data.dirtTemp!.toDouble()),
                      HumidityWidget(
                        value: data.airHumidity!.toDouble(),
                        text: "Hava Nem",
                      ),
                      HumidityWidget(
                        value: data.dirtHumidity!.toDouble(),
                        text: "Toprak Nem",
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
