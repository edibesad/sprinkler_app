import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/ui/home/view/components/devices_list_element.dart';
import 'package:sprinkler_app/ui/home/view_model/home_view_model.dart';

class DevicesListView extends StatelessWidget {
  const DevicesListView({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Obx(() => GridView.builder(
            itemCount: viewModel.incomingData.length,
            itemBuilder: (context, index) =>
                DevicesListElement(viewModel.incomingData[index]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio:
                    orientation == Orientation.landscape ? 1.8 : 0.68),
          ));
    });
  }
}
