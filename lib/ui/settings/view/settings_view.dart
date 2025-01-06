import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sprinkler_app/core/base/view/base_view.dart';
import 'package:sprinkler_app/core/components/my_text_field.dart';
import 'package:sprinkler_app/ui/settings/view/components/settings_element.dart';

import '../view_model/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: SettingsViewModel(),
        onViewModelReady: (model) => model.init(),
        onPageBuild: (context, viewModel) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: context.height * 0.4,
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  top: context.height * 0.3,
                  left: context.width * 0.1,
                  right: context.width * 0.1,
                  bottom: context.height * 0.1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(122),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    height: context.height * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ListTile(
                            subtitle: Text(
                              "Ayarlar",
                            ),
                          ),
                          SettingsElement(
                              icon: const Icon(Icons.wifi),
                              title: "Bağlantı Türü",
                              subtitle: Obx(() {
                                return viewModel.isLocal.value
                                    ? const Text("Yerel Bağlantı")
                                    : const Text("Uzak Bağlantı");
                              }),
                              child: Obx(() {
                                return Row(
                                  spacing: 50,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Uzak Bağlantı"),
                                    Switch(
                                        value: viewModel.isLocal.value,
                                        onChanged:
                                            viewModel.connectionTypeOnChanged),
                                    const Text("Yerel Bağlantı"),
                                  ],
                                );
                              })),
                          SettingsElement(
                              icon: const Icon(Icons.language),
                              title: "Sunucu Adresi",
                              subtitle: Text(viewModel.appViewModel.host ?? ""),
                              onSave: viewModel.saveServerAddress,
                              onCancel: viewModel.onServerAddressCancel,
                              child: MyTextField(
                                labelText: "Sunucu Adresi",
                                controller:
                                    viewModel.serverAddressController.value,
                              )),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              child: const Icon(
                                Icons.exit_to_app,
                                color: Colors.red,
                              ),
                            ),
                            iconColor: Colors.red,
                            textColor: Colors.red,
                            title: const Text("Çıkış"),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: viewModel.exitApp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
