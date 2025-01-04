import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/base/view/base_view.dart';
import 'package:sprinkler_app/ui/device_details/view_model/device_details_view_model.dart';
import 'package:sprinkler_app/ui/home/view/components/humidity_widget.dart';
import 'package:sprinkler_app/ui/home/view/components/thermometer_widget.dart';

class DeviceDetails extends StatelessWidget {
  const DeviceDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseView(
      onViewModelReady: (model) {
        model.init();
      },
      onPageBuild: (context, viewModel) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          backgroundColor: const Color.fromRGBO(16, 38, 148, 20),
        ),
        body: OrientationBuilder(
            builder: (context, orientation) => Obx(() {
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            orientation == Orientation.landscape ? 1.8 : 0.68),
                    children: [
                      ThermometerWidget(
                          text: "Sıcaklık (°C)",
                          currentTemperature:
                              viewModel.data.value.airTemp!.toDouble()),
                      ThermometerWidget(
                          text: "Toprak Sıcaklığı (°C)",
                          currentTemperature:
                              viewModel.data.value.dirtTemp!.toDouble()),
                      HumidityWidget(
                        value: viewModel.data.value.airHumidity!.toDouble(),
                        text: "Hava Nem",
                      ),
                      HumidityWidget(
                        value: viewModel.data.value.dirtHumidity!.toDouble(),
                        text: "Toprak Nem",
                      ),
                    ]
                        .map(
                          (e) => Card(
                            child: e,
                          ),
                        )
                        .toList(),
                  );
                })),
      ),
      viewModel: DeviceDetailsViewModel(),
    );
  }
}
