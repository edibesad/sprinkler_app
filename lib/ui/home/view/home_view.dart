import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/base/view/base_view.dart';
import 'package:sprinkler_app/ui/home/view/components/devices_list_view.dart';
import 'package:sprinkler_app/ui/home/view_model/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: HomeViewModel(),
      onViewModelReady: (model) {
        model.init();
      },
      onPageBuild: (context, viewModel) => Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(16, 38, 148, 1),
          onPressed: viewModel.toSettings,
          child: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
        body: Center(child: Obx(() {
          return viewModel.isLoading.value
              ? const CircularProgressIndicator()
              : viewModel.error.value == null
                  ? DevicesListView(viewModel: viewModel)
                  : Column(
                      spacing: 40,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(viewModel.error.value!),
                        IconButton(
                            onPressed: viewModel.connectToSocket,
                            icon: const Icon(Icons.refresh))
                      ],
                    );
        })),
      ),
    );
  }
}
