import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sprinkler_app/core/base/view/base_view.dart';
import 'package:sprinkler_app/ui/device_configuration/view/companents/configuration_component.dart';
import 'package:sprinkler_app/ui/device_configuration/view/companents/configuration_humidity.dart';
import 'package:sprinkler_app/ui/device_configuration/view_model/device_configuration_view_model.dart';

class DeviceConfiguration extends StatelessWidget {
  const DeviceConfiguration({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: DeviceConfigurationViewModel(),
        onPageBuild: (context, viewModel) => Scaffold(
              body: OrientationBuilder(
                builder: (context, orientation) => GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          orientation == Orientation.landscape ? 1.8 : 0.68),
                  children: [
                    ConfigurationComponent(
                      text: "Sıcaklık",
                    ),
                    ConfigurationComponent(
                      text: "Toprak Sıcaklık",
                    ),
                    ConfigurationHumidity(
                      text: "Nem",
                    ),
                    ConfigurationHumidity(
                      text: "Toprak Nem",
                    ),
                  ]
                      .map(
                        (e) => Card(
                          child: e,
                        ),
                      )
                      .toList(),
                ),
              ),
            ));
  }
}
