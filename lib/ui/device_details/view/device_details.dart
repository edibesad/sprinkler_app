import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sprinkler_app/core/base/view/base_view.dart';
import 'package:sprinkler_app/core/extension/context_extension.dart';
import 'package:sprinkler_app/ui/device_details/view/components/sprinkler_animation.dart';
import 'package:sprinkler_app/ui/device_details/view_model/device_details_view_model.dart';
import 'package:sprinkler_app/ui/home/view/components/humidity_widget.dart';
import 'package:sprinkler_app/ui/home/view/components/thermometer_widget.dart';

import 'components/history.dart';

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
          onPressed: viewModel.goToConfiguration,
          backgroundColor: const Color.fromRGBO(16, 38, 148, 1),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: OrientationBuilder(
              builder: (context, orientation) => Obx(() {
                    return Column(
                      children: [
                        Text(
                          viewModel.data.value.sensorId.toString(),
                          style: GoogleFonts.nunito(
                              fontSize: context.highValue * 0.5,
                              color: const Color.fromRGBO(16, 38, 148, 1)),
                        ),
                        Expanded(
                          child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio:
                                        orientation == Orientation.landscape
                                            ? 1.8
                                            : 0.68),
                            children: [
                              Card(
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 20,
                                  children: [
                                    Text(
                                      "Kalan Süre \n${viewModel.hour.toString()} saat ${viewModel.minute.toString()} dakika",
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    if (viewModel.data.value.work != 0)
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                            textStyle: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: viewModel.cancelWork,
                                          child: const Text("Sulama İptal Et"))
                                  ],
                                )),
                              ),
                              Card(
                                  color: Colors.grey[200],
                                  child:
                                      SprinklerAnimation(viewModel: viewModel)),
                              Card(
                                color: Colors.grey[200],
                                child: ThermometerWidget(
                                    showHistoryButton:
                                        !viewModel.appViewModel.isLocal,
                                    sensorId: viewModel.data.value.sensorId!,
                                    yValue: YValue.temperature,
                                    mac: viewModel.data.value.macId!,
                                    text: "Sıcaklık (°C)",
                                    currentTemperature: viewModel
                                        .data.value.airTemp!
                                        .toDouble()),
                              ),
                              Card(
                                child: ThermometerWidget(
                                    showHistoryButton:
                                        !viewModel.appViewModel.isLocal,
                                    mac: viewModel.data.value.macId!,
                                    sensorId: viewModel.data.value.sensorId!,
                                    yValue: YValue.dirtTemperature,
                                    text: "Toprak Sıcaklığı (°C)",
                                    currentTemperature: viewModel
                                        .data.value.dirtTemp!
                                        .toDouble()),
                              ),
                              Card(
                                child: HumidityWidget(
                                  showHistoryButton:
                                      !viewModel.appViewModel.isLocal,
                                  mac: viewModel.data.value.macId!,
                                  sensorId: viewModel.data.value.sensorId!,
                                  yValue: YValue.humidity,
                                  value: viewModel.data.value.airHumidity!
                                      .toDouble(),
                                  text: "Hava Nem",
                                ),
                              ),
                              Card(
                                color: Colors.grey[200],
                                child: HumidityWidget(
                                  showHistoryButton:
                                      !viewModel.appViewModel.isLocal,
                                  mac: viewModel.data.value.macId!,
                                  sensorId: viewModel.data.value.sensorId!,
                                  yValue: YValue.dirtHumidity,
                                  value: viewModel.data.value.dirtHumidity!
                                      .toDouble(),
                                  text: "Toprak Nem",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  })),
        ),
      ),
      viewModel: DeviceDetailsViewModel(),
    );
  }
}
