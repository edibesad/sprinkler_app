import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/base/view/base_view.dart';
import 'package:sprinkler_app/core/components/my_button.dart';
import 'package:sprinkler_app/ui/device_configuration/view/components/configuration_component.dart';
import 'package:sprinkler_app/ui/device_configuration/view/components/configuration_humidity.dart';
import 'package:sprinkler_app/ui/device_configuration/view/components/configuration_temperature.dart';
import 'package:sprinkler_app/ui/device_configuration/view_model/device_configuration_view_model.dart';

class DeviceConfigurationView extends StatelessWidget {
  const DeviceConfigurationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
        onViewModelReady: (model) => model.init(),
        viewModel: DeviceConfigurationViewModel(),
        onPageBuild: (context, viewModel) => Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: OrientationBuilder(
                      builder: (context, orientation) => Obx(() {
                        return GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio:
                                        orientation == Orientation.landscape
                                            ? 1.8
                                            : 0.68),
                            children: [
                              ConfigurationComponent(
                                onCheckboxChanged:
                                    viewModel.airTempCheckboxOnChanged,
                                child: ConfigurationTemperature(
                                  initLowerValue: (viewModel
                                              .incomingData.value.minAirTemp ??
                                          -40)
                                      .toDouble(),
                                  initUpperValue: (viewModel
                                              .incomingData.value.maxAirTemp ??
                                          50)
                                      .toDouble(),
                                  onChanged: viewModel.setTemperature,
                                  text: "Sıcaklık",
                                  maximum: 50,
                                  minimum: -40,
                                ),
                              ),
                              ConfigurationComponent(
                                onCheckboxChanged:
                                    viewModel.dirtTempCheckboxOnChanged,
                                child: ConfigurationTemperature(
                                  initLowerValue: (viewModel
                                              .incomingData.value.minDirtTemp ??
                                          -40)
                                      .toDouble(),
                                  initUpperValue: (viewModel
                                              .incomingData.value.maxDirtTemp ??
                                          50)
                                      .toDouble(),
                                  onChanged: viewModel.setDirtTemperature,
                                  text: "Toprak Sıcaklığı",
                                  maximum: 50,
                                  minimum: -40,
                                ),
                              ),
                              ConfigurationComponent(
                                onCheckboxChanged:
                                    viewModel.airHumidityCheckboxOnChanged,
                                child: ConfigurationHumidity(
                                  startValue: (viewModel.incomingData.value
                                              .minAirHumidity ??
                                          0)
                                      .toDouble(),
                                  endValue: (viewModel.incomingData.value
                                              .maxAirHumidity ??
                                          100)
                                      .toDouble(),
                                  onChanged: viewModel.setAirHumidity,
                                  text: "Hava Nem",
                                ),
                              ),
                              ConfigurationComponent(
                                  onCheckboxChanged:
                                      viewModel.dirtHumidityCheckboxOnChanged,
                                  child: ConfigurationHumidity(
                                    startValue: (viewModel.incomingData.value
                                                .minDirtHumidity ??
                                            0)
                                        .toDouble(),
                                    endValue: (viewModel.incomingData.value
                                                .maxDirtHumidity ??
                                            100)
                                        .toDouble(),
                                    onChanged: viewModel.setDirtHumidity,
                                    text: "Toprak Nem",
                                  )),
                            ]);
                      }),
                    ),
                  ),
                  SizedBox(
                    width: context.width * .2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyButton(
                        icon1: Icons.save,
                        icon2: Icons.check,
                        text: "Kaydet",
                        onPressed: viewModel.save,
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
